INSERT INTO um_user (um_user_name, um_user_password, um_salt_value, um_require_change, um_changed_time, um_tenant_id)
  VALUES ('test@lpg.dev.cshr.digital', 'CpfcMRB1+ErcVc4On0/58md9xOC6cxMl/WOg71v5TA4=', 'tApkvY3NRkg2EMmxO50kLA==', 'f', '2018-01-18 15:36:19.407', -1234);

INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'uid', 'test@lpg.dev.cshr.digital', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'scimId', 'f6bb29cb-876f-45fa-b851-34f6569d35d2', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'lastModifiedDate', '2018-01-18T15:36:19', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'createdDate', '2018-01-18T15:36:19', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'profession', 'commercial', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'department', 'dh', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'grade', 'SCS', 'default', um_id, -1234 FROM um_user where um_user_name = 'test@lpg.dev.cshr.digital';

INSERT INTO um_user (um_user_name, um_user_password, um_salt_value, um_require_change, um_changed_time, um_tenant_id)
  VALUES ('lpg-ui', 'AaQTU+KK/v4WX+uVd/Sr6vmQYPDbm6l4njw9AGkmgQE=', 'lq645lAVYahTJadkVmF8FA==', 'f', '2018-01-18 15:36:19.407', -1234);

INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'uid', 'lpg-ui', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'scimId', 'a1960382-b153-4653-a419-256b2c584935', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'lastModifiedDate', '2018-01-18T15:36:19', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'createdDate', '2018-01-18T15:36:19', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'profession', 'commercial', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'department', 'dh', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
INSERT INTO um_user_attribute (um_attr_name, um_attr_value, um_profile_id, um_user_id, um_tenant_id) SELECT 'grade', 'SCS', 'default', um_id, -1234 FROM um_user where um_user_name = 'lpg-ui';
