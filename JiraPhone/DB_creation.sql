PRAGMA foreign_keys=ON;

CREATE TABLE "issues" 
("key" TEXT PRIMARY KEY,
"assignee" TEXT, 
"created" DATETIME, 
"description" TEXT,
"due_date" DATETIME,
"priority" TEXT, 
"project" TEXT, 
"reporter" TEXT, 
"resolution" TEXT check(typeof("resolution") = 'text') , 
"status" TEXT check(typeof("status") = 'text') ,
"summary" TEXT check(typeof("summary") = 'text') , 
"type" TEXT check(typeof("type") = 'text') , 
"updated" DATETIME, 
"user_id" TEXT, 
"server" TEXT,
FOREIGN KEY (project) REFERENCES projects(key) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (reporter) REFERENCES users(name) ON UPDATE CASCADE ON DELETE SET NULL,
FOREIGN KEY (user_id) REFERENCES users(name) ON UPDATE CASCADE ON DELETE SET NULL);

CREATE INDEX issueData on issues(updated);

CREATE TABLE "projects" 
("key" TEXT PRIMARY KEY, 
"description" TEXT, 
"lead" TEXT, 
"project_url" TEXT, 
"url" TEXT, 
"name" TEXT, 
"user_id" TEXT, 
"server" TEXT,
"hashcode" INTEGER);

CREATE TABLE "users" 
("name" TEXT PRIMARY KEY, 
"full_name" TEXT, 
"email" TEXT,
"server" TEXT, 
"hashcode" INTEGER
);

CREATE TABLE "comments"
("Id" TEXT PRIMARY KEY,
"author" TEXT,
"body" TEXT,
"updated" DATETIME,
"created" DATETIME,
"issueId" TEXT,
"server" TEXT,
FOREIGN KEY (author) REFERENCES users(name) ON UPDATE CASCADE ON DELETE SET NULL,
FOREIGN KEY (issueId) REFERENCES issues(key) ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE "versions"
("id" TEXT PRIMARY KEY,
"name" TEXT,
"releaseDate" DATETIME,
"server" TEXT,
"sequence" INTEGER);

CREATE TABLE "roleactor"
("id" INTEGER PRIMARY KEY,
"description" TEXT,
"name" TEXT,
"server" TEXT,
"hashcode" INTEGER
);

CREATE TABLE "projectrole"
("id" INTEGER PRIMARY KEY,
"name" TEXT,
"description" TEXT,
"server" TEXT,
"hashcode" INTEGER
);

CREATE TABLE "groups"
("name" TEXT NOT NULL,
"server" TEXT NOT NULL,
"user_name" TEXT,
FOREIGN KEY (user_name) REFERENCES users(name) ON DELETE CASCADE
);


CREATE TABLE "userroleactors"
("ID" INTEGER PRIMARY KEY AUTOINCREMENT,
"projectrole_id" INTEGER,
"roleactor_id" INTEGER,
"user_name" TEXT,
FOREIGN KEY (projectrole_id) REFERENCES projectrole(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (roleactor_id) REFERENCES roleactor(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (user_name) references users(name) ON UPDATE CASCADE ON DELETE SET NULL
);
