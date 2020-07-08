/**
* The base interceptor test case will use the 'interceptor' annotation as the instantiation path to the interceptor
* and then create it, prepare it for mocking, and then place it in the variables scope as 'interceptor'. It is your
* responsibility to update the interceptor annotation instantiation path.
*/
component extends="coldbox.system.testing.BaseInterceptorTest" interceptor="interceptors.SecurityInterceptor"{

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();
		configProperties = {
			nonSecuredHandlers = "mainTest"
			, nonSecuredItems = "main.test,main.viewForgotPassword,main.processForgotPassword,main.robots"
			, loginFormItem = "main.viewLogin"
			, loginSubmitItem = "main.processLogin"
			, logoutSubmitItem = "main.processLogout"
			, resetPasswordFormItem = "main.viewChangePassword"
		};
		super.setup();
		mockUserService = getMockBox().createEmptyMock("model.services.userService");
		interceptor.$property("userService", "variables", mockUserService);
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run(){
		describe("interceptors.SecurityInterceptor", function() {
			var mockEvent = {};
			var mockData = {};
			var mockUser = {};
			beforeEach(function(spec) {
				mockEvent = getMockRequestContext();
				mockData = {};
				mockUser = getMockBox().createEmptyMock("model.domains.User");
			});
			it("should configure correctly", function() {
				var configureFn = function() { interceptor.configure(); };
				expect(configureFn).notToThrow();
			});
			it("should handle permitted handlers", function() {
				var nonSecuredHandlerFn = function() {
					interceptor.preProcess(mockEvent, mockData);
				};
				mockEvent.$("getCurrentEvent", "mainTest.testAction");
				expect(nonSecuredHandlerFn).notToThrow();
				mockEvent.$("getCurrentEvent", "blah.testAction");
				expect(nonSecuredHandlerFn).toThrow();
			});
			it("should handle permitted events", function() {
				var nonSecuredItemsFn = function() {
					interceptor.preProcess(mockEvent, mockData);
				};
				var events = listToArray(configProperties.nonSecuredItems);
				events.each(function(event) {
					mockEvent.$("getCurrentEvent", event);
					expect(nonSecuredItemsFn).notToThrow();
				})
			});
			it("should allow login submit", function() {
				var loginSubmitItemFn = function() {
					interceptor.preProcess(mockEvent, mockData);
				};
				mockEvent.$("getCurrentEvent", "main.processLogin");
				mockUser.$("getIntUserId", 42);
				mockUser.$("setIsLoggedIn");
				mockUser.$("getIsLoggedIn", true);
				mockUser.$("getBtIsPasswordExpired", false);
				mockUserService.$("authenticateUser", mockUser);
				expect(loginSubmitItemFn).notToThrow();
				expect(session.user).toBe(mockUser);
			});
			it("should allow logout submit", function() {
				var logoutSubmitItemFn = function() {
					interceptor.preProcess(mockEvent, mockData);
				};
				mockEvent.$("getCurrentEvent", "main.processLogout");
				mockUserService.$("getEmptyDomain", mockUser);
				expect(logoutSubmitItemFn).toThrow();
				expect(session.user).toBe(mockUser);
			});
			it("should allow any event when logged in", function() {
				var fnAnyEvent = function() {
					interceptor.preProcess(mockEvent, mockData);
				};
				mockUser.$("isLoggedIn", true);
				session.user = mockUser;
				mockEvent.$("getCurrentEvent", "main.index");
				expect(fnAnyEvent).notToThrow();
			});
			it("should not allow any event when logged out", function() {
				var fnAnyEvent = function() {
					interceptor.preProcess(mockEvent, mockData);
				};
				mockUser.$("isLoggedIn", false);
				session.user = mockUser;
				mockEvent.$("getCurrentEvent", "main.index");
				expect(fnAnyEvent).toThrow();
			});
		});
	}
}
