DROP INDEX player_score_tenant_id_player_id_idx;

CREATE INDEX player_score_player_id_idx on player_score(player_id);
CREATE INDEX player_score_competition_id_idx on player_score(competition_id);
CREATE INDEX competition_tenant_id_created_at_idx on competition(tenant_id, created_at);
