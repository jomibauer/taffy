component accessors=true extends="baseService" singleton=true {

	public any function init() {

		variables.statesArray = [
			{ stateAbbr: "AL", stateName: "Alabama" },
			{ stateAbbr: "AK", stateName: "Alaska" },
			{ stateAbbr: "AZ", stateName: "Arizona" },
			{ stateAbbr: "AR", stateName: "Arkansas" },
			{ stateAbbr: "CA", stateName: "California" },
			{ stateAbbr: "CO", stateName: "Colorado" },
			{ stateAbbr: "CT", stateName: "Connecticut" },
			{ stateAbbr: "DE", stateName: "Delaware" },
			{ stateAbbr: "FL", stateName: "Florida" },
			{ stateAbbr: "GA", stateName: "Georgia" },
			{ stateAbbr: "HI", stateName: "Hawaii" },
			{ stateAbbr: "ID", stateName: "Idaho" },
			{ stateAbbr: "IL", stateName: "Illinois" },
			{ stateAbbr: "IN", stateName: "Indiana" },
			{ stateAbbr: "IO", stateName: "Iowa" },
			{ stateAbbr: "KS", stateName: "Kansas" },
			{ stateAbbr: "KY", stateName: "Kentucky" },
			{ stateAbbr: "LA", stateName: "Louisiana" },
			{ stateAbbr: "ME", stateName: "Maine" },
			{ stateAbbr: "MD", stateName: "Maryland" },
			{ stateAbbr: "MA", stateName: "Massachusetts" },
			{ stateAbbr: "MI", stateName: "Michigan" },
			{ stateAbbr: "MN", stateName: "Minnesota" },
			{ stateAbbr: "MS", stateName: "Mississippi" },
			{ stateAbbr: "MO", stateName: "Missouri" },
			{ stateAbbr: "MT", stateName: "Montana" },
			{ stateAbbr: "NE", stateName: "Nebraska" },
			{ stateAbbr: "NV", stateName: "Nevada" },
			{ stateAbbr: "NH", stateName: "New Hampshire" },
			{ stateAbbr: "NJ", stateName: "New Jersey" },
			{ stateAbbr: "NM", stateName: "New Mexico" },
			{ stateAbbr: "NY", stateName: "New York" },
			{ stateAbbr: "NC", stateName: "North Carolina" },
			{ stateAbbr: "ND", stateName: "North Dakota" },
			{ stateAbbr: "OH", stateName: "Ohio" },
			{ stateAbbr: "OK", stateName: "Oklahoma" },
			{ stateAbbr: "OR", stateName: "Oregon" },
			{ stateAbbr: "PA", stateName: "Pennsylvania" },
			{ stateAbbr: "RI", stateName: "Rhode Island" },
			{ stateAbbr: "SC", stateName: "South Carolina" },
			{ stateAbbr: "SD", stateName: "South Dakota" },
			{ stateAbbr: "TN", stateName: "Tennessee" },
			{ stateAbbr: "TX", stateName: "Texas" },
			{ stateAbbr: "UT", stateName: "Utah" },
			{ stateAbbr: "VT", stateName: "Vermont" },
			{ stateAbbr: "VA", stateName: "Virginia" },
			{ stateAbbr: "WA", stateName: "Washington" },
			{ stateAbbr: "DC", stateName: "Washington,D.C" },
			{ stateAbbr: "WV", stateName: "West Virginia" },
			{ stateAbbr: "WI", stateName: "Wisconsin" },
			{ stateAbbr: "WY", stateName: "Wyoming" }
		];

		return this;
	}

	function getAllStatesJSONforAutocomplete() {

		// @jquery-autocomplete (<- search for this tag to find other places where jquery-autocomplete is being documented)
		// the statesArray has to be mapped to new objects with "label" and "value" keys instead
		// of "stateName" and "stateAbbr" keys because jquery's autocomplete expects them in this format.
		
		var output = statesArray.map(function(item) {
			var data["label"] = item.stateName;
				data["value"] = item.stateAbbr;
			return data;
		});

		return serializeJSON(output);
	}

	function getAllStates() {
		return statesArray;
	}

}