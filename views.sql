  CREATE VIEW v_stmr_norm_bat_pa AS
  SELECT t.fg_id,
         NULL /*1.0*t.g/pa*/ AS g,
         1.0*t.pa AS pa,
         1.0*t.ab/t.pa AS ab,
         1.0*(t.h - t.b2 - t.b3 - t.hr)/t.pa AS b1,
         1.0*t.b2/t.pa AS b2,
         1.0*t.b3/t.pa AS b3,
         1.0*t.hr/t.pa AS hr,
         1.0*t.r/t.pa AS r,
         1.0*t.rbi/t.pa AS rbi,
         1.0*t.bb/t.pa AS bb,
         1.0*t.so/t.pa AS so,
         1.0*t.sb/t.pa AS sb,
         1.0*t.cs/t.pa AS cs
    FROM stmr_norm_bat t
;

  CREATE VIEW v_dept_bat_pa AS
  SELECT t.fg_id,
         1.0*t.g/pa AS g,
         1.0*t.pa AS pa,
         1.0*t.ab/t.pa AS ab,
         1.0*(t.h - t.b2 - t.b3 - t.hr)/t.pa AS b1,
         1.0*t.b2/t.pa AS b2,
         1.0*t.b3/t.pa AS b3,
         1.0*t.hr/t.pa AS hr,
         1.0*t.r/t.pa AS r,
         1.0*t.rbi/t.pa AS rbi,
         1.0*t.bb/t.pa AS bb,
         1.0*t.so/t.pa AS so,
         1.0*t.sb/t.pa AS sb,
         1.0*t.cs/t.pa AS cs
    FROM dept_bat t
;

  CREATE VIEW v_zips_bat_pa AS
  SELECT t.fg_id,
         1.0*t.g/pa AS g,
         1.0*t.pa AS pa,
         1.0*t.ab/t.pa AS ab,
         1.0*(t.h - t.b2 - t.b3 - t.hr)/t.pa AS b1,
         1.0*t.b2/t.pa AS b2,
         1.0*t.b3/t.pa AS b3,
         1.0*t.hr/t.pa AS hr,
         1.0*t.r/t.pa AS r,
         1.0*t.rbi/t.pa AS rbi,
         1.0*t.bb/t.pa AS bb,
         1.0*t.so/t.pa AS so,
         1.0*t.sb/t.pa AS sb,
         1.0*t.cs/t.pa AS cs
    FROM zips_bat t
;

  CREATE VIEW v_pod_bat_pa AS
  SELECT t.fg_id,
         1.0*t.g/pa AS g,
         1.0*t.pa AS pa,
         1.0*t.ab/t.pa AS ab,
         1.0*(t.h - t.b2 - t.b3 - t.hr)/t.pa AS b1,
         1.0*t.b2/t.pa AS b2,
         1.0*t.b3/t.pa AS b3,
         1.0*t.hr/t.pa AS hr,
         1.0*t.r/t.pa AS r,
         1.0*t.rbi/t.pa AS rbi,
         1.0*t.bb/t.pa AS bb,
         1.0*t.so/t.pa AS so,
         1.0*t.sb/t.pa AS sb,
         1.0*t.cs/t.pa AS cs
    FROM pod_bat t
;

  CREATE VIEW v_razz_bat_pa AS
  SELECT COALESCE(u.fg_id, v.fg_id, t.bis_id) AS fg_id,
         1.0*t.g/pa AS g,
         1.0*t.pa AS pa,
         1.0*t.ab/t.pa AS ab,
         1.0*(t.h - t.b2 - t.b3 - t.hr)/t.pa AS b1,
         1.0*t.b2/t.pa AS b2,
         1.0*t.b3/t.pa AS b3,
         1.0*t.hr/t.pa AS hr,
         1.0*t.r/t.pa AS r,
         1.0*t.rbi/t.pa AS rbi,
         1.0*t.bb/t.pa AS bb,
         1.0*t.so/t.pa AS so,
         1.0*t.sb/t.pa AS sb,
         1.0*t.cs/t.pa AS cs
    FROM razz_bat t
    LEFT
    JOIN id_map u ON u.fg_id = t.bis_id
    LEFT
    JOIN (
  SELECT fg_name,
         MAX(fg_id) AS fg_id
    FROM id_map
GROUP BY fg_name
  HAVING COUNT(*) = 1
         ) v ON v.fg_name = t.name
;

  CREATE VIEW v_clay_bat_pa AS
  SELECT COALESCE(u.fg_id, v.fg_id) AS fg_id,
         NULL /*1.0*t.g/pa*/ AS g,
         1.0*t.pa AS pa,
         1.0*t.ab/t.pa AS ab,
         1.0*(t.h - t.b2 - t.b3 - t.hr)/t.pa AS b1,
         1.0*t.b2/t.pa AS b2,
         1.0*t.b3/t.pa AS b3,
         1.0*t.hr/t.pa AS hr,
         1.0*t.r/t.pa AS r,
         1.0*t.rbi/t.pa AS rbi,
         1.0*t.bb/t.pa AS bb,
         1.0*t.so/t.pa AS so,
         1.0*t.sb/t.pa AS sb,
         1.0*t.cs/t.pa AS cs
    FROM clay_bat t
    LEFT
    JOIN id_map u ON u.howe_id = t.howe_id
    LEFT
    JOIN (
  SELECT fg_name,
         MAX(fg_id) AS fg_id
    FROM id_map
GROUP BY fg_name
  HAVING COUNT(*) = 1
         ) v ON v.fg_name = t.first || ' ' || t.last
;


  SELECT t.fg_id,
         MAX(u.fg_name),
         COUNT(*),
         SUM(t.weight*hr)/SUM(t.weight) AS hr
    FROM (
  SELECT v_stmr_norm_bat_pa.*, 'stmr_norm' AS source, 2 AS weight FROM v_stmr_norm_bat_pa
   UNION
     ALL
  SELECT v_zips_bat_pa.*, 'zips' AS source, 1 AS weight FROM v_zips_bat_pa
   UNION
     ALL
  SELECT v_pod_bat_pa.*, 'pod' AS source, 1 AS weight FROM v_pod_bat_pa
   UNION
     ALL
  SELECT v_razz_bat_pa.*, 'razz' AS source, 1 AS weight FROM v_razz_bat_pa
   UNION
     ALL
  SELECT v_clay_bat_pa.*, 'clay' AS source, 0.5 AS weight FROM v_clay_bat_pa
         ) t
    LEFT
    JOIN id_map u ON u.fg_id = t.fg_id
GROUP BY t.fg_id
;
