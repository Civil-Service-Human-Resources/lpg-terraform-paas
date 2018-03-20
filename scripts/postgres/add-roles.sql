
INSERT INTO um_role (um_role_name, um_tenant_id, um_shared_role) VALUES ('learner', -1234, false);
INSERT INTO um_role (um_role_name, um_tenant_id, um_shared_role) VALUES ('management', -1234, false);

INSERT INTO um_user_role (um_role_id, um_user_id, um_tenant_id) VALUES (
  (SELECT um_id FROM um_role WHERE um_role_name = 'learner'),
  (SELECT um_id FROM um_user WHERE um_user_name = 'test@lpg.dev.cshr.digital'),
  -1234
);

INSERT INTO um_user_role (um_role_id, um_user_id, um_tenant_id) VALUES (
  (SELECT um_id FROM um_role WHERE um_role_name = 'management'),
  (SELECT um_id FROM um_user WHERE um_user_name = 'test@lpg.dev.cshr.digital'),
  -1234
);
