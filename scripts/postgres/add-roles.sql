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

INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/learner', 'urn:ietf:params:scim:schemas:core:2.0:id', 'f750323b-d72f-48db-b045-73810cb5f96e');
INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/learner', 'urn:ietf:params:scim:schemas:core:2.0:meta.created', '2018-03-20T13:42:51Z');
INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/learner', 'urn:ietf:params:scim:schemas:core:2.0:meta.lastModified', '2018-03-20T13:42:51Z');
INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/learner', 'urn:ietf:params:scim:schemas:core:2.0:meta.location', 'https://localhost:9443/scim2/Groups/f750323b-d72f-48db-b045-73810cb5f96e');

INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/management', 'urn:ietf:params:scim:schemas:core:2.0:id', '56b5fea8-4b20-4dfa-9859-e5551d474a94');
INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/management', 'urn:ietf:params:scim:schemas:core:2.0:meta.created', '2018-03-20T13:42:51Z');
INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/management', 'urn:ietf:params:scim:schemas:core:2.0:meta.lastModified', '2018-03-20T13:42:51Z');
INSERT INTO idn_scim_group (tenant_id, role_name, attr_name, attr_value) VALUES (-1234, 'PRIMARY/management', 'urn:ietf:params:scim:schemas:core:2.0:meta.location', 'https://localhost:9443/scim2/Groups/56b5fea8-4b20-4dfa-9859-e5551d474a94');