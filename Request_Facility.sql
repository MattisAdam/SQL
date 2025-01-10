SELECT 
	f.Code,
	COUNT(*) AS 'How many operations is opened for each facility'
FROM 
	PRM_Operation op
	INNER JOIN CORP_Facility f ON op.FacilityId = f.Id
WHERE 
	OperationStatusId = 1

GROUP BY 
	f.Code
-------------------------------
SELECT 
	*
FROM 
	LKP_OperationStatus