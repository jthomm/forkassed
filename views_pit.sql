  CREATE VIEW v_fg_id_by_fg_name_pit AS
  SELECT t.fg_name,
         MAX(t.fg_id) AS fg_id
    FROM id_map t
   WHERE t.role = 'pit'
GROUP BY t.fg_name
  HAVING COUNT(*) = 1
;

  CREATE VIEW v_dept_pit_ip AS
  SELECT t.fg_id,
         1.0*t.g/t.ip g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.so/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         1.0*t.sv/t.ip sv,
         NULL bsv,
         NULL hld,
         NULL qs,
         CASE WHEN 1.0*t.gs/t.g >= 0.6 THEN 'SP' ELSE 'RP' END role
    FROM dept_pit t
;

  CREATE VIEW v_stmr_norm_pit_ip AS
  SELECT t.fg_id,
         1.0*t.g/t.ip g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.so/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         1.0*t.sv/t.ip sv,
         NULL bsv,
         NULL hld,
         NULL qs,
         CASE WHEN 1.0*t.gs/t.g >= 0.6 THEN 'SP' ELSE 'RP' END role
    FROM stmr_norm_pit t
;

  CREATE VIEW v_pod_pit_ip AS
  SELECT t.fg_id,
         CASE WHEN t.role = 'S' THEN t.gs/t.ip ELSE 1 END g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.so/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         1.0*t.sv/t.ip sv,
         NULL bsv,
         NULL hld,
         1.0*t.qs/t.ip qs,
         CASE WHEN t.role = 'S' THEN 'SP' ELSE 'RP' END role
    FROM pod_pit t
;

  CREATE VIEW v_zips_pit_ip AS
  SELECT t.fg_id,
         1.0*t.g/t.ip g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.so/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         NULL sv,
         NULL bsv,
         NULL hld,
         NULL qs,
         CASE WHEN 1.0*t.gs/t.g >= 0.6 THEN 'SP' ELSE 'RP' END role
    FROM zips_pit t
;

  CREATE VIEW v_clay_adj_pit_ip AS
  SELECT COALESCE(u.fg_id, v.fg_id) AS fg_id,
         1.0*t.g/t.ip g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.so/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         1.0*t.sv/t.ip sv,
         NULL bsv,
         NULL hld,
         1.0*t.qs/t.ip qs,
         CASE WHEN t.role = 'Sta' THEN 'SP' ELSE 'RP' END role
    FROM clay_adj_pit t
    LEFT
    JOIN id_map u
      ON u.howe_id = t.howe_id
    LEFT
    JOIN v_fg_id_by_fg_name_pit v
      ON v.fg_name = t.first || ' ' || t.last
;

  CREATE VIEW v_razz_pit_ip AS
  SELECT COALESCE(u.fg_id, v.fg_id, t.bis_id) AS fg_id,
         1.0*t.g/t.ip g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.k/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         1.0*t.sv/t.ip sv,
         NULL bsv,
         1.0*t.hld/t.ip hld,
         1.0*t.qs/t.ip qs,
         t.pos role
    FROM razz_pit t
    LEFT
    JOIN id_map u
      ON u.fg_id = t.bis_id
    LEFT
    JOIN v_fg_id_by_fg_name_pit v
      ON v.fg_name = t.name
;

  CREATE VIEW v_atc_pit_ip AS
  SELECT t.fg_id,
         1.0*t.g/t.ip g,
         1.0*t.gs/t.ip gs,
         t.ip ip,
         1.0*t.h/t.ip h,
         1.0*t.er/t.ip er,
         1.0*t.bb/t.ip bb,
         1.0*t.so/t.ip so,
         1.0*t.hr/t.ip hr,
         1.0*t.w/t.ip w,
         1.0*t.l/t.ip l,
         1.0*t.sv/t.ip sv,
         NULL bsv,
         NULL hld,
         NULL qs,
         CASE WHEN 1.0*t.gs/t.g >= 0.6 THEN 'SP' ELSE 'RP' END role
    FROM atc_pit t
;

  CREATE VIEW v_union_pit_ip AS
  SELECT 'stmr_norm' AS source, t.* FROM v_stmr_norm_pit_ip t
   UNION
     ALL
  SELECT 'zips' AS source, t.* FROM v_zips_pit_ip t
   UNION
     ALL
  SELECT 'pod' AS source, t.* FROM v_pod_pit_ip t
   UNION
     ALL
  SELECT 'razz' AS source, t.* FROM v_razz_pit_ip t
   UNION
     ALL
  SELECT 'clay_adj' AS source, t.* FROM v_clay_adj_pit_ip t
   UNION
     ALL
  SELECT 'dept' AS source, t.* FROM v_dept_pit_ip t
   UNION
     ALL
  SELECT 'atc' AS source, t.* FROM v_atc_pit_ip t
;

  CREATE VIEW v_average_pit_ip AS
  SELECT t.fg_id,
         SUM(u.g*t.g)/SUM(u.g) AS g,
         SUM(u.gs*t.gs)/SUM(u.gs) AS gs,
         SUM(u.ip*t.ip)/SUM(u.ip) AS ip,
         SUM(u.h*t.h)/SUM(u.h) AS h,
         SUM(u.er*t.er)/SUM(u.er) AS er,
         SUM(u.bb*t.bb)/SUM(u.bb) AS bb,
         SUM(u.so*t.so)/SUM(u.so) AS so,
         SUM(u.hr*t.hr)/SUM(u.hr) AS hr,
         SUM(u.w*t.w)/SUM(u.w) AS w,
         SUM(u.l*t.l)/SUM(u.l) AS l,
         SUM(u.sv*t.sv)/SUM(u.sv) AS sv,
         SUM(u.bsv*t.bsv)/SUM(u.bsv) AS bsv,
         SUM(u.hld*t.hld)/SUM(u.hld) AS hld,
         SUM(u.qs*t.qs)/SUM(u.qs) AS qs,
         SUM(CASE t.source WHEN 'stmr_norm' THEN 1 ELSE 0 END) AS stmr_norm,
         SUM(CASE t.source WHEN 'zips' THEN 1 ELSE 0 END) AS zips,
         SUM(CASE t.source WHEN 'pod' THEN 1 ELSE 0 END) AS pod,
         SUM(CASE t.source WHEN 'razz' THEN 1 ELSE 0 END) AS razz,
         SUM(CASE t.source WHEN 'clay_adj' THEN 1 ELSE 0 END) AS clay_adj,
         SUM(CASE t.source WHEN 'dept' THEN 1 ELSE 0 END) AS dept,
         SUM(CASE t.source WHEN 'atc' THEN 1 ELSE 0 END) AS atc,
         COUNT(*) AS sources,
         SUM(CASE t.role WHEN 'SP' THEN 1 ELSE 0 END) AS sp
    FROM v_union_pit_ip t
    JOIN weights_pit u
      ON u.source = t.source
GROUP BY t.fg_id
;

  CREATE VIEW v_pit AS
  SELECT t.fg_id,
         u.fg_name,
         u.yh_pos AS pos,
         t.ip*t.g AS g,
         t.ip*t.gs AS gs,
         t.ip,
         9.0*t.er AS era,
         t.bb + t.h AS whip,
         t.ip*t.h AS h,
         t.ip*t.er AS er,
         t.ip*t.bb AS bb,
         t.ip*t.so AS so,
         t.ip*t.hr AS hr,
         t.ip*t.w AS w,
         t.ip*t.l AS l,
         t.ip*t.sv AS sv,
         t.ip*t.bsv AS bsv,
         t.ip*t.hld AS hld,
         t.ip*t.qs AS qs,
         t.stmr_norm,
         t.zips,
         t.pod,
         t.razz,
         t.clay_adj,
         t.dept,
         t.atc,
         t.sources,
         t.sp
    FROM v_average_pit_ip t
    LEFT
    JOIN id_map u ON u.fg_id = t.fg_id
   WHERE stmr_norm = 1
     AND razz = 1
     AND atc + pod >= 1
;

  CREATE VIEW v_pit_value AS
  SELECT *,
         5.6022*w/g - 1.9762 AS w_v,
         4.214*sv/g - 0.4692 AS sv_v,
         (1/3.73)*(1.0*ip/g)*(3.07 - era) AS era_v,
         1.656*(1.0*ip/g)*(1.14 - whip) AS whip_v,
         0.5047*so/g - 2.336 AS so_v
    FROM v_pit
;
