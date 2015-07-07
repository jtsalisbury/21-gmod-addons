bankConfig = {};
bankConfig.bankPos = {
	Vector(-1172.042480, 1386.968750, -200.968750), 
	Vector(-1318.102539, 1151.031250, -78.183167)
};												// Where is the bank located.
bankConfig.bankVault = {
	Vector(-792.031250, 1258.951538, -87.968750), 
	Vector(-1172.066406, 1386.968750, -200.968750)
}
bankConfig.bankGuards = {TEAM_POLICE};			// What teams are considered "bank security".
bankConfig.bankGuardWeapons = {"weapon_ar2"};	// What weapons do bank security get.
bankConfig.initialMoney = 1000;						// How much money does the bank start out with.
bankConfig.moneyGrowth = 200;						// How much money does the bank get every interval of time.
bankConfig.moneyGrowthTime = 4;					// How long does it take for the bank to increase its worth. --Should be in seconds!
bankConfig.robTime = 10;
bankConfig.maxMoney = 20000;					//How high should the vault's storage go
bankConfig.minMoney = 2000;						//Min money required for raiding