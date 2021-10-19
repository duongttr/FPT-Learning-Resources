CREATE DATABASE STORE_DB;
USE STORE_DB;

-- 1
CREATE TABLE KHACHHANG (
    MAKH CHAR(4) PRIMARY KEY, 
    HOTEN VARCHAR(40) NOT NULL, 
    DCHI VARCHAR(50), 
    SODT VARCHAR(20),   
    NGSINH SMALLDATETIME NOT NULL, 
    DOANHSO MONEY,
    NGDK SMALLDATETIME NOT NULL
)

CREATE TABLE NHANVIEN (
    MANV CHAR(4) PRIMARY KEY,
    HOTEN VARCHAR(40) NOT NULL, 
    NGVL SMALLDATETIME NOT NULL, 
    SODT VARCHAR(20)
)

CREATE TABLE SANPHAM (
    MASP CHAR(4) PRIMARY KEY,
    TENSP VARCHAR(40) NOT NULL, 
    DVT VARCHAR(20) NOT NULL, 
    NUOCSX VARCHAR(40) NOT NULL, 
    GIA MONEY NOT NULL
)


CREATE TABLE HOADON (
    SOHD INT PRIMARY KEY, 
    NGHD SMALLDATETIME NOT NULL, 
    MAKH CHAR(4), 
    MANV CHAR(4), 
    TRIGIA MONEY NOT NULL,

    FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)

CREATE TABLE CTHD (
    SOHD INT,
    MASP CHAR(4),
    SL INT NOT NULL,
    
    PRIMARY KEY (SOHD, MASP),

    FOREIGN KEY (SOHD) REFERENCES HOADON(SOHD),
    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP)
)

-- 2
ALTER TABLE SANPHAM ADD GHICHU VARCHAR(20);

-- 3
ALTER TABLE KHACHHANG ADD LOAIKH TINYINT;

-- 4
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU VARCHAR(100);

-- 5
ALTER TABLE SANPHAM
DROP COLUMN GHICHU;

-- 6
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH VARCHAR(20);

-- 7
ALTER TABLE SANPHAM
ADD CONSTRAINT chk_DVT CHECK (DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc'))

-- 8
ALTER TABLE SANPHAM
ADD CONSTRAINT chk_GIA CHECK (GIA >= 500)

-- 9
ALTER TABLE CTHD
ADD CONSTRAINT chk_HOADON CHECK (
    (SELECT COUNT(DISTINCT CTHD.SOHD) FROM HOADON
    INNER JOIN CTHD
    ON HOADON.SOHD=CTHD.SOHD)=(SELECT COUNT(SOHD) FROM HOADON)
),
CONSTRAINT chk_SL CHECK (SL > 0)

-- 10
ALTER TABLE KHACHHANG
ADD CONSTRAINT chk_NGDK_NSINH
CHECK (NGDK > NGSINH)

-- 11
ALTER TABLE HOADON
ADD CONSTRAINT chk_NGHD_NGDK
CHECK (
    (SELECT COUNT(*) FROM HOADON
    INNER JOIN KHACHHANG
    ON HOADON.MAKH=KHACHHANG.MAKH WHERE HOADON.NGHD < KHACHHANG.NGDK)!=0
)

-- 12
ALTER TABLE HOADON
ADD CONSTRAINT chk_NGHD_NGVL
CHECK (
    (SELECT COUNT(*) FROM HOADON
    INNER JOIN NHANVIEN
    ON HOADON.MANV=NHANVIEN.MANV WHERE HOADON.NGHD < NHANVIEN.NGVL)!=0
)

-- 13
ALTER TABLE HOADON
ADD CONSTRAINT chk_CTHD CHECK(
    (SELECT COUNT(CTHD.MASP) FROM (SELECT COUNT(CTHD.MASP) FROM HOADON
    RIGHT JOIN CTHD ON HOADON.SOHD=CTHD.SOHD
    GROUP BY CTHD.MASP HAVING COUNT(CTHD.MASP) = 0))!=0
)
