const check = (op, actual, expected) => {
	if(!op || !op.op) return false;
	
	switch (op.op) {
		case 'eq':
			return actual === expected;
		default:
			return false;
	}
}

const isEnabled = (config, param) => {
	if(config || !config.enabled) return false;
	
	let flag = true
	const keys = Object.keys(config);
	for (var i = 0; i < keys.length; i++) {
		const key = keys[i];
		switch (key) {
			case 'mobileAppVersion':
				if(!param.mobileAppVersion || !param.mobileAppVersion.op) {
					flag = false;
				}
				flag &= check(param.mobileAppVersion.op, param.mobileAppVersion, param.mobileAppVersion.value);
				break;
			
			default:
				// code
				break;
		}
		if(!flag) break;
	}
	return flag;
}

module.exports = {
  isEnabled,
}
