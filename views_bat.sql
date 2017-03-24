  CREATE VIEW v_fg_id_by_fg_name_bat AS
  SELECT t.fg_name,
         MAX(t.fg_id) AS fg_id
    FROM id_map t
   WHERE t.role = 'bat'
GROUP BY t.fg_name
  HAVING COUNT(*) = 1
;

  CREATE VIEW v_stmr_norm_bat_pa AS
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
    JOIN id_map u
      ON u.fg_id = t.bis_id
    LEFT
    JOIN v_fg_id_by_fg_name_bat v
      ON v.fg_name = t.name
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
    JOIN id_map u
      ON u.howe_id = t.howe_id
    LEFT
    JOIN v_fg_id_by_fg_name_bat v
      ON v.fg_name = t.first || ' ' || t.last
;

  CREATE VIEW v_clay_adj_bat_pa AS
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
    FROM clay_adj_bat t
    LEFT
    JOIN id_map u
      ON u.howe_id = t.howe_id
    LEFT
    JOIN v_fg_id_by_fg_name_bat v
      ON v.fg_name = t.first || ' ' || t.last
;

  CREATE VIEW v_union_bat_pa AS
  SELECT 'stmr_norm' AS source, t.* FROM v_stmr_norm_bat_pa t
   UNION
     ALL
  SELECT 'zips' AS source, t.* FROM v_zips_bat_pa t
   UNION
     ALL
  SELECT 'pod' AS source, t.* FROM v_pod_bat_pa t
   UNION
     ALL
  SELECT 'razz' AS source, t.* FROM v_razz_bat_pa t
   UNION
     ALL
  SELECT 'clay_adj' AS source, t.* FROM v_clay_adj_bat_pa t
   UNION
     ALL
  SELECT 'dept' AS source, t.* FROM v_dept_bat_pa t
;

  CREATE VIEW v_average_bat_pa AS
  SELECT t.fg_id,
         SUM(u.g*t.g)/SUM(u.g) AS g,
         SUM(u.pa*t.pa)/SUM(u.pa) AS pa,
         SUM(u.ab*t.ab)/SUM(u.ab) AS ab,
         SUM(u.b1*t.b1)/SUM(u.b1) AS b1,
         SUM(u.b2*t.b2)/SUM(u.b2) AS b2,
         SUM(u.b3*t.b3)/SUM(u.b3) AS b3,
         SUM(u.hr*t.hr)/SUM(u.hr) AS hr,
         SUM(u.r*t.r)/SUM(u.r) AS r,
         SUM(u.rbi*t.rbi)/SUM(u.rbi) AS rbi,
         SUM(u.bb*t.bb)/SUM(u.bb) AS bb,
         SUM(u.so*t.so)/SUM(u.so) AS so,
         SUM(u.sb*t.sb)/SUM(u.sb) AS sb,
         SUM(u.cs*t.cs)/SUM(u.cs) AS cs,
         SUM(CASE t.source WHEN 'stmr_norm' THEN 1 ELSE 0 END) AS stmr_norm,
         SUM(CASE t.source WHEN 'zips' THEN 1 ELSE 0 END) AS zips,
         SUM(CASE t.source WHEN 'pod' THEN 1 ELSE 0 END) AS pod,
         SUM(CASE t.source WHEN 'razz' THEN 1 ELSE 0 END) AS razz,
         SUM(CASE t.source WHEN 'clay_adj' THEN 1 ELSE 0 END) AS clay_adj,
         SUM(CASE t.source WHEN 'dept' THEN 1 ELSE 0 END) AS dept,
         COUNT(*) AS sources
    FROM v_union_bat_pa t
    JOIN weights_bat u
      ON u.source = t.source
GROUP BY t.fg_id
;

  CREATE VIEW v_bat AS
  SELECT t.fg_id,
         u.fg_name,
         u.yh_pos AS pos,
         t.pa*t.g AS g,
         t.pa,
         (t.b1 + t.b2 + t.b3 + t.hr)/t.ab AS ba,
         t.pa*t.ab AS ab,
         t.pa*t.b1 AS b1,
         t.pa*t.b2 AS b2,
         t.pa*t.b3 AS b3,
         t.pa*t.hr AS hr,
         t.pa*t.r AS r,
         t.pa*t.rbi AS rbi,
         t.pa*t.bb AS bb,
         t.pa*t.so AS so,
         t.pa*t.sb AS sb,
         t.pa*t.cs AS cs,
         t.stmr_norm,
         t.zips,
         t.pod,
         t.razz,
         t.clay_adj,
         t.dept,
         t.sources
    FROM v_average_bat_pa t
    LEFT
    JOIN id_map u ON u.fg_id = t.fg_id
   WHERE stmr_norm = 1
     AND razz = 1
     AND dept = 1
     AND zips + pod >= 1
;
