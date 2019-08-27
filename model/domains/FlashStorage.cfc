component name="FlashStorage" {

	any function init () {
		variables.instance = {};
	}

	void function set (required string key, required any value) {
		variables.instance[key] = value;
	}

	void function store(required struct rc, required string key, any defaultValue = "") {
		if (structKeyExists(rc, key)) {
			set(key, rc[key]);
		} else {
			set(key, defaultValue);
		}
	}

	struct function get () {
		local.out = duplicate(variables.instance);
		structClear(variables.instance);
		return local.out;
	}

	void function restore (required struct rc) {
		structAppend(arguments.rc, get());
	}
}