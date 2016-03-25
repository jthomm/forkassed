CREATE TABLE id_map (
    fg_id TEXT
  , fg_name TEXT
  , role TEXT
  , fg_last TEXT
  , fg_first TEXT
  , bbm_id TEXT
  , bbm_last TEXT
  , bbm_first TEXT
  , yh_id TEXT
  , yh_last TEXT
  , yh_first TEXT
  , yh_team TEXT
  , yh_pos TEXT
  , howe_id TEXT
  , cbs_id TEXT
  , bam_id TEXT
)
;

CREATE UNIQUE INDEX ui_id_map_fg_id ON id_map(fg_id);
