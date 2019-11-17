CREATE OR REPLACE FUNCTION mae_plano
() 
RETURNS trigger AS $mae_plano$

BEGIN
  IF NEW.mae_forma_pagamento = 'Plano de saude' AND
    NEW.mae_plano_de_saude NOTNULL THEN
  RETURN NEW;
  ELSE
  RETURN NULL;
END
IF;
END;
$mae_plano$ LANGUAGE plpgsql;

CREATE TRIGGER mae_plano BEFORE
INSERT OR
UPDATE ON mae
    FOR EACH ROW
EXECUTE FUNCTION mae_plano
();