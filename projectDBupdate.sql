--UPDATE
UPDATE 
	S24_S003_T6_BUS
SET 
	Type = 'Local'
WHERE 
	BNumber = 'N1JVHP';


UPDATE 
	S24_S003_T6_BUS
SET 
	Type = 'Intercity'
WHERE 
	BNumber = 'PJI6KW';


UPDATE 
	S24_S003_T6_BUS
SET 
	Type = 'Express'
WHERE 
	BNumber = 'OZE7T5';


UPDATE 
	S24_S003_T6_DRIVER
SET 
	Email = 'jhernandez@example.com'
WHERE 	
	DID = 10;

UPDATE 
	S24_S003_T6_DRIVER
SET 
	DOB = '1984-04-23'
WHERE 
	DID = 15;


UPDATE 
	S24_S003_T6_DRIVER
SET 
	Name = 'Mariah Gomez'
WHERE 
	DID = 25;

--INSERT
INSERT INTO S24_S003_T6_PASSENGER (PID, Email, Name, Password, Username, City, Zip, Street, State, Apt_no, DOB) VALUES 
(51, 'smithjohn@example.com', 'John Smith', 'P@ssw0rd123', 'jsmith', 'New York', '10001', 'Main Street', 'NY', '123', '1980-05-15');

INSERT INTO S24_S003_T6_PASSENGER (PID, Email, Name, Password, Username, City, Zip, Street, State, Apt_no, DOB) 
VALUES (52, 'alexander92@example.net', 'Emily Alexander', 'SecurePwd!23', 'emalex', 'Los Angeles', '90001', 'Sunset Boulevard', 'CA', '456', '1992-08-28');

INSERT INTO S24_S003_T6_PASSENGER (PID, Email, Name, Password, Username, City, Zip, Street, State, Apt_no, DOB) 
VALUES (53, 'millerlisa@example.com', 'Lisa Miller', 'SecretPass456', 'lmiller', 'Chicago', '60601', 'Michigan Avenue', 'IL', '789', '1978-03-12');

INSERT INTO S24_S003_T6_PASSENGER (PID, Email, Name, Password, Username, City, Zip, Street, State, Apt_no, DOB) 
VALUES (54, 'davidthomas@example.org', 'David Thomas', 'P@55w0rd', 'dthomas', 'Houston', '77001', 'Main Street', 'TX', '567', '1985-11-07');

INSERT INTO S24_S003_T6_PASSENGER (PID, Email, Name, Password, Username, City, Zip, Street, State, Apt_no, DOB) 
VALUES (55, 'rachel87@example.net', 'Rachel Martinez', 'P@ssw0rd', 'rmartinez', 'Miami', '33101', 'Ocean Drive', 'FL', '890', '1987-09-14');


--DELETE
DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '1' 
AND 
	Phone_No = '777-123-4567';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '5' 
AND 
	Phone_No = '222-234-5678';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '6' 
AND 
	Phone_No = '111-432-1098';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '7' 
AND 
	Phone_No = '333-210-9876';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '8' 
AND 
	Phone_No = '555-890-1234';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '11' 
AND 
	Phone_no = '999-456-8901';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '16' 
AND 
	Phone_no = '777-345-6789';

DELETE FROM 
	S24_S003_T6_PASSENGER_PHONE 
WHERE 
	PID = '21' 
AND 
	Phone_no = '666-012-3456';