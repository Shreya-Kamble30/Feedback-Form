CREATE DATABASE college;

USE college;

CREATE TABLE feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    message TEXT NOT NULL
);

SELECT * FROM feedback;