CREATE TABLE toys
    (toyid int PRIMARY KEY NOT NULL,
    toyname varchar(25) NOT NULL,
    Price money NULL,
    about varchar(max) NULL)
GO
INSERT toys(toyid,toyname, Price, about)
    VALUES (1, 'Clamp', 12.48, 'Workbench clamp')
GO
INSERT toys(toyid,toyname, Price, about)
    VALUES (2, 'magic', 20, 'chings')
GO