
-------------------------------------> Table Creation <-----------------------------------------

create table Games
(
	GameCode char(10) not null,
	GameName varchar(100),
	Descriptions varchar(800),
	Comments varchar(200),
	
	primary key (GameCode)
	
);
	
create table Players
(
	PlayerID int not null,
	FirstName varchar(50),
	LastName varchar(50),
	Gender varchar(10),
	Others varchar(50),
	
	primary key (PlayerID)
	
);
	
create table Teams 
(
	TeamID int not null,
	TeamName varchar(20),
	DateCreated datetime not null,
	DateDisbaned datetime,
	Others varchar(50),
	
	primary key (TeamID)
	
);
	
create table Team_Players
(
	TeamID int not null,
	PlayerID int not null,
	DateFrom datetime not null,
	DateTo datetime,
	Other varchar(50),
	
	primary key (TeamID,PlayerID),
	foreign key (TeamID) references Teams (TeamID),
	foreign key (PlayerID) references Players (PlayerID)
);
	
create table Matches
 (
	MatchID int not null,
	GameCode char(10) not null,
	MatchDate datetime not null,
	Others varchar(50),
	
	primary key (MatchID),
	foreign key (GameCode) references Games (GameCode)
	
);
	
	
create table Player_Ranking
 (
	PlayerID int not null,
	GameCode char(10) not null,
	Ranking int,
	
	primary key(PlayerID,GameCode),
	foreign key (PlayerID) references Players (PlayerID),
	foreign key (GameCode) references Games (GameCode)
	
);
	
create table Gamewise_Teams
 (
	GameCode char(10) not null,
	TeamID int not null,
	
	primary key (GameCode,TeamID),
	foreign key (GameCode) references Games (GameCode),
	foreign key (TeamID) references Teams (TeamID)
	
);
	

-------------------------------------> Data Insertion <-----------------------------------------


-->Games
	
insert into Games values ('A001','Fortnite','Shooting Game','No Comments');
insert into Games values ('A002','Call of Duty','Shooting Game','Mediocre');
insert into Games values ('B001','Player Unknown:Battleground','Shooting Game','');
insert into Games values ('A003','Counter Strike','Shooting Game','');
insert into Games values ('B002','DOTA 2','Strategy','');
insert into Games values ('B003','League of Legends','Strategy',''); 
insert into Games values ('B004','World of Warcraft','Strategy','');


-->Players

insert into Players values (01,'Arnob','Sanzam','Male','');
insert into Players values (02,'Anik','Shahzaman','Male','');
insert into Players values (03,'Adit','Azman','Male','');
insert into Players values (04,'Ahnaf','Sabit','Male','');
insert into Players values (05,'Nusrat','Anika','Female','');
insert into Players values (06,'Iffatun','Nesa','Female','');
insert into Players values (07,'Parisa','Pew','Female','');
insert into Players values (08,'Martha','Wayne','Female','');



-->Teams

insert into Teams  values (01,'TrailBlazer','01-20-2016',null,'Experienced');
insert into Teams values (02,'Tri-Core','01-11-2018',null,'');
insert into Teams values (03,'Nihilist','12-12-2017',null,'');
insert into Teams values (04,'Fairy Tale','09-07-2017',null,'Beginner');


-->Team_Players

insert into Team_Players values (01,01,'01-20-2016',null,'');
insert into Team_Players values (01,02,'01-20-2016',null,'');
insert into Team_Players values (01,03,'01-20-2016',null,'');
insert into Team_Players values (02,05,'01-11-2016',null,'');
insert into Team_Players values (02,06,'01-11-2016',null,'');
insert into Team_Players values (03,04,'12-12-2016',null,'');
insert into Team_Players values (02,07,'12-12-2016',null,'');
insert into Team_Players values (04,01,'12-12-2016',null,'');
insert into Team_Players values (03,08,'12-12-2016',null,'');



-->Gamewise_Teams

insert into Gamewise_Teams values ('A001',01);
insert into Gamewise_Teams values ('A001',02);
insert into Gamewise_Teams values ('A001',03);
insert into Gamewise_Teams values ('A002',01);
insert into Gamewise_Teams values ('A002',04);
insert into Gamewise_Teams values ('B001',03);



-->Matches

insert into Matches values (01,'A001','2018-10-10','');
insert into Matches values (02,'A001','2018-10-11','');
insert into Matches values (03,'A001','2018-10-12','');
insert into Matches values (04,'B001','2018-10-11','');
insert into Matches values (05,'B001','2018-10-12','');
insert into Matches values (06,'A002','2018-10-20','');
insert into Matches values (07,'A002','2018-09-21','');
insert into Matches values (08,'A001','2018-09-29','');
insert into Matches values (09,'B004','2018-10-12','');



-->Player_ranking

insert into Player_Ranking values (01,'A001',1);
insert into Player_Ranking values (02,'A001',3);
insert into Player_Ranking values (03,'A001',5);
insert into Player_Ranking values (01,'A002',2);
insert into Player_Ranking values (04,'A002',7);
insert into Player_Ranking values (05,'A001',2);



----------------------------------------> Query Starts <---------------------------------------------


---------> General User Query <---------

-->1 All Games
select * from Games;

-->2 All Players
select * from Players;

-->3 All Teams
select * from Teams;

-->4 All Team_Players
select * from Team_Players;

-->5 All Gamewise_Teams
select * from Gamewise_Teams;

-->6 All Matches
select * from Matches;

-->7 All Player_Ranking
select * from Player_Ranking;

-->8 Ordered by an Attribute
select * from Games
order by GameName ;

select * from Games
order by GameCode desc;

-->9 Types of game
	-->i)
		select distinct Descriptions from Games;
	-->ii)
		select distinct GameCode from Player_Ranking;


-->10 Top 3 ranked players of 'Fortnite'
select * from Players p,Player_Ranking pr
where pr.PlayerID = p.PlayerID and pr.Ranking <= 3 and
GameCode = (Select GameCode from Games where GameName = 'Fortnite') ; 

-->11 Basic Searching
	-->i)
		select * from Games
		where Descriptions like 'Sh%';
	-->ii)
		select * from Games
		where GameCode like 'B%';


-->12 joining Players and Player_Ranking
	-->i)
		select * from Players p,Player_Ranking pr
		where p.PlayerID = pr.PlayerID and pr.Ranking in (1,3);
	-->ii)
		select * from Players p,Player_Ranking pr
		where p.PlayerID = pr.PlayerID and pr.Ranking between 1 and 3 ;


-->13 Partial Information
	-->i)
		select top 3 * from Players;
	-->ii)
		select top 60 percent * from Players;

-->14 Players of each Gender
select Gender,COUNT(PlayerID) as 'PlayerNumber'
from Players group by Gender;

-->15 Number of Games under each category
select Descriptions,COUNT(GameCode) as 'NumberOfgames'
from Games group by Descriptions;

-->16 Number of Players who play Fortnite
select GameCode,COUNT(PlayerId) as 'Number of Players' 
from Player_Ranking group by GameCode having 
GameCode = (Select GameCode from Games where GameName ='Fortnite') ;


-->17 Fortnite Player Ranking
select p.PlayerID,p.FirstName + ' ' + p.LastName as 'PlayerName',p.Gender,pr.GameCode,pr.Ranking 
from Players p inner join Player_Ranking pr
on p.PlayerID = pr.PlayerID and pr.GameCode = (Select GameCode from Games where GameName ='Fortnite') ; 

-->18 Overall Player Ranking
select p.playerID,p.firstname + ' ' + p.lastname as 'Player Name',
p.gender as'Gender',pr.GameCode,pr.Ranking
from Players p,Player_Ranking pr
where p.playerID = pr.playerID ;


-->19 Players information of each Gender
	-->i)
		select * from Players
		where Gender in 
		(select Gender from Players where Gender = 'Female');

	-->ii)

		select * from Players
		where Gender in 
		(select Gender from Players where Gender = 'Male');


-->20 Top 3 players of Fortnite
select * from Players p inner join Player_Ranking pr
on p.PlayerID = pr.PlayerID and pr.GameCode = (Select GameCode from Games where GameName ='Fortnite') and Ranking in
(select Top 3 Ranking from Player_Ranking 
where GameCode = (Select GameCode from Games where GameName ='Fortnite') order by ranking )
order by pr.Ranking ;

-->21 All Gamewise Teams information
select t.TeamID,gt.GameCode,t.TeamName,t.DateCreated,t.DateDisbaned,t.Others from Teams t,Gamewise_Teams gt
where t.TeamID = gt.TeamID order by gt.GameCode;

-->22 Which Team plays which Game
select g.GameCode,g.GameName,gt.TeamID,t.TeamName from Games g,Gamewise_Teams gt,Teams t
where g.GameCode = gt.GameCode and gt.TeamID = t.TeamID order by g.GameCode;

-->23 Number of Teams per Game
select g.GameName,COUNT(Distinct gt.TeamID)as 'Number of Teams' 
from Games g,Gamewise_Teams gt
where g.GameCode = gt.GameCode 
group by g.GameName;

-->24 'Fortnite' Match Dates
select * from Matches
where GameCode = 'A001';

-->25 Future Match Dates
select * from Matches
where MatchDate > GETDATE() ;

-->26 Finished Matches
select * from Matches
where MatchDate < GETDATE() ;

-->27 Today's Match (If there is any)
select * from Matches
where MatchDate = GETDATE() ;

-->28 Team Matches
	-->i)
		select m.MatchId,m.GameCode,t.TeamName,m.Matchdate from Matches m,Teams t,Gamewise_Teams gt
		where t.TeamID = gt.TeamID and gt.GameCode = m.GameCode  
		order by m.GameCode;
	-->ii)
		select m.MatchId,m.GameCode,t.TeamName,m.Matchdate from Matches m,Teams t,Gamewise_Teams gt
		where t.TeamID = gt.TeamID and gt.GameCode = m.GameCode and t.TeamID = 01  
		order by m.GameCode;


-->29 Basic Union
select GameName from Games
where Descriptions = 'strategy'
UNION
select GameName from Games
where Comments = 'No Comments';

-->30 Gamewise Player Ranking
select Top 3 pr.Ranking,pr.PlayerID,p.FirstName from Player_Ranking pr,Players p
where pr.PlayerID = p.PlayerID and pr.GameCode = 'A001' and pr.Ranking in
(select Top 4 Ranking from Player_Ranking
order by Ranking) order by Ranking;

---------------------------------------------------------------------------------------------------


---------> Admin Query <---------
-->31 Basic Update
update Players 
set FirstName = 'Bruce',LastName = 'Wayne'
where PlayerID = 08;

-->32 Basic Delete
delete from Players
where PlayerID = 08;

-->33 Updating Team Players
update Team_Players
set DateTo = GETDATE()
where TeamID = 01 and PlayerID = 03;

-->34  Disbanding Teams 
update Teams
set DateDisbaned = GETDATE()
where TeamID = 04 ;

-->35 Updating Team Players from Disbanding Teams
update Team_Players
set DateTo = GETDATE()
where TeamID in 
(select TeamID from Teams
where TeamName = 'Nihilist');

-->36 All Disbanded Teams
select * from Teams
where DateDisbaned != ' ' ;	

-->37 Changing Game-wise Teams
Update Gamewise_Teams
set TeamID = 04
where TeamID = 02 and GameCode = 'A002';

-->38 Deleting Teams from Teams_Players
delete from Teams
where TeamID in 
(select TeamID from Team_Players
where DateTo != '');
	    
-->39 Deleting Team Players
delete from Team_Players
where TeamID in
(select TeamID from Teams
where DateDisbaned != '');

-->40 Disbanding Player
update Players
set Others = 'Disbanded'
where PlayerID = 04

-->41 Removing disbanded player from Player_Ranking
delete from Player_Ranking
where PlayerID in
(select PlayerID from Players
where PlayerID = 04);
  
-->42 Removing disbanded player from Team_players
delete from Team_Players
where PlayerID in
(select PlayerID from Players
where PlayerID = 04 ) ;

-->43 Assemble Team Players of Disbaned Teams
update Team_Players
set DateTo = ''
where TeamID in
( select TeamID from Teams
where DateDisbaned != '' );

-->44 Adding comments in Games table
update Games
set Comments = 'First person Shooting game'
where GameCode = 'A002' ;

-->45 Dropping/Truncating Tables
DROP table Players;
DROP table teams;
DROP table Matches;
TRUNCATE table Players; 

--------------------------------------------------------------------------------------------------
























	    
	    






