﻿CREATE TABLE [tblStrings] (
  [ID] AUTOINCREMENT CONSTRAINT [PrimaryKey] PRIMARY KEY UNIQUE NOT NULL,
  [msgid] LONGTEXT,
  [Context] LONGTEXT,
  [Comments] LONGTEXT
)