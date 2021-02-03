--# Copyright IBM Corp. All Rights Reserved.
--# SPDX-License-Identifier: Apache-2.0

/*
 * Shows any column group statistics that have been defined
 */

CREATE OR REPLACE VIEW DB_COLUMN_GROUPS AS
SELECT
    C.TABSCHEMA
,   C.TABNAME
,   C.COLUMNS
,   G.COLGROUPCARD
FROM
(
	SELECT  TABSCHEMA, TABNAME, COLGROUPID
	,       LISTAGG('"' || COLNAME || '"',', ') WITHIN GROUP (ORDER BY ORDINAL) AS COLUMNS
	FROM
            SYSCAT.COLGROUPCOLS
	GROUP BY
	       TABSCHEMA, TABNAME, COLGROUPID
)   AS C
INNER JOIN 
        SYSCAT.COLGROUPS G
ON
   C.COLGROUPID = G.COLGROUPID