-- drop table mvp_position;
-- create table to add player position to most_valuable_player
create table mvp_position as(
select trim(mvp.team) as team, mvp.sb_no, trim(mvp.player) as player, mvp.position_abbr, pp.position, mvp.highlights
  from most_valuable_player mvp,
       player_position pp
 where trim(mvp.position_abbr) = trim(pp.abbreviation)
  );
  
select * from mvp_position;

-- create table to add winner division 
create table winner_div as(
select qb.sb_no, trim(qb.winner_team) as winner_team,  trim(t.team_division) as winner_div
 from sb_quarterbacks qb, teams t
where lower(trim(qb.winner_team)) = lower(trim(t.team_name))); 

-- create table to add loser division
create table loser_div as(
select qb.sb_no, trim(qb.loser_team) as loser_team, trim(t.team_division) as loser_div
from sb_quarterbacks qb, teams t
  where lower(trim(qb.loser_team)) = lower(trim(t.team_name)));


update scores
   set stadium = 'Mercedes-Benz Superdome'
 where stadium = 'Mercedes-Benz Stadium';

--drop table superbowl;
-- below table is created in jupyter notebook
create table superbowl as(
   select sb.sb_no, sb.year, qb.winner_conf, wd.winner_div, trim(qb.winner_team) as winner_team, 
       sb.winner_score, trim(qb.winner_qb) as winner_qb, qb.also_mvp, trim(s.stadium) as stadium, 
	   trim(st.city) as city, trim(st.state) as state,
       qb.loser_conf, ld.loser_div, trim(qb.loser_team) as loser_team, 
	   sb.loser_score, trim(qb.loser_qb) as loser_qb
  from sb_winners sb, sb_quarterbacks qb, winner_div as wd, loser_div as ld, scores as s, stadiums as st
 where trim(sb.sb_no) = trim(qb.sb_no)
   and trim(qb.sb_no) = trim(wd.sb_no)
   and trim(qb.sb_no) = trim(ld.sb_no)
   and lower(trim(qb.winner_team)) = lower(trim(wd.winner_team))
   and lower(trim(qb.loser_team)) = lower(trim(ld.loser_team))
   and (sb.year - 1) = s.schedule_season
   and lower(trim(s.schedule_week)) = 'superbowl'
   and lower(trim(s.stadium)) = lower(trim(st.stadium_name))
   order by year);