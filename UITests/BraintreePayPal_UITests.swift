/*
IMPORTRANT
Hardware keyboard should be disabled on simulator for tests to run reliably.
*/

import XCTest

class BraintreePayPal_FuturePayment_UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-Integration:BraintreeDemoPayPalForceFuturePaymentViewController")
        app.launch()
        app.buttons["PayPal (future payment button)"].forceTapElement()
        sleep(2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPayPal_futurePayment_receivesNonce() {
        let app = XCUIApplication()
        
        let webviewElementsQuery = app.webViews.element.otherElements
        let emailTextField = webviewElementsQuery.textFields["Email"]
        
        self.waitForElementToAppear(emailTextField)
        emailTextField.forceTapElement()
        sleep(1)
        emailTextField.typeText("test@paypal.com")
        
        let passwordTextField = webviewElementsQuery.secureTextFields["Password"]
        passwordTextField.forceTapElement()
        sleep(1)
        passwordTextField.typeText("1234")

        webviewElementsQuery.buttons["Log In"].forceTapElement()
        
        self.waitForElementToAppear(webviewElementsQuery.buttons["Agree"])
        
        webviewElementsQuery.buttons["Agree"].forceTapElement()
        
        self.waitForElementToAppear(app.buttons["Got a nonce. Tap to make a transaction."])
        
        XCTAssertTrue(app.buttons["Got a nonce. Tap to make a transaction."].exists);
    }
    
    func testPayPal_futurePayment_cancelsSuccessfully() {
        let app = XCUIApplication()
        
        let webviewElementsQuery = app.webViews.element.otherElements
        let emailTextField = webviewElementsQuery.textFields["Email"]
        
        self.waitForElementToAppear(emailTextField)
        
        // Close button has no accessibility helper
        // Purposely don't use the webviewElementsQuery variable
        // Reevaluate the elements query after the page load to get the close button
        app.webViews.buttons.elementBoundByIndex(0).forceTapElement()
        
        self.waitForElementToAppear(app.buttons["PayPal (future payment button)"])
        
        XCTAssertTrue(app.buttons["Canceled 🔰"].exists);
    }
}

class BraintreePayPal_SinglePayment_UITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-Integration:BraintreeDemoPayPalOneTimePaymentViewController")
        app.launch()
        app.buttons["PayPal one-time payment"].forceTapElement()
        sleep(2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPayPal_singlePayment_receivesNonce() {
        let app = XCUIApplication()
        let webviewElementsQuery = app.webViews.element.otherElements

        self.waitForElementToAppear(webviewElementsQuery.links["Proceed with Sandbox Purchase"])
        
        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()
        
        self.waitForElementToAppear(app.buttons["Got a nonce. Tap to make a transaction."])
        
        XCTAssertTrue(app.buttons["Got a nonce. Tap to make a transaction."].exists);
    }
    
    func testPayPal_singlePayment_cancelsSuccessfully() {
        let app = XCUIApplication()
        let webviewElementsQuery = app.webViews.element.otherElements

        self.waitForElementToAppear(webviewElementsQuery.links["Cancel Sandbox Purchase"])
        
        webviewElementsQuery.links["Cancel Sandbox Purchase"].forceTapElement()
        
        self.waitForElementToAppear(app.buttons["PayPal one-time payment"])
        
        XCTAssertTrue(app.buttons["Cancelled"].exists);
    }
}

class BraintreePayPal_BillingAgreement_UITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-Integration:BraintreeDemoPayPalBillingAgreementViewController")
        app.launch()
        app.buttons["Billing Agreement with PayPal"].forceTapElement()
        sleep(2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPayPal_billingAgreement_receivesNonce() {
        let app = XCUIApplication()
        let webviewElementsQuery = app.webViews.element.otherElements

        self.waitForElementToAppear(webviewElementsQuery.links["Proceed with Sandbox Purchase"])
        
        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()
        
        self.waitForElementToAppear(app.buttons["Got a nonce. Tap to make a transaction."])
        
        XCTAssertTrue(app.buttons["Got a nonce. Tap to make a transaction."].exists);
    }
    
    func testPayPal_billingAgreement_cancelsSuccessfully() {
        let app = XCUIApplication()
        let webviewElementsQuery = app.webViews.element.otherElements

        self.waitForElementToAppear(webviewElementsQuery.links["Cancel Sandbox Purchase"])
        
        webviewElementsQuery.links["Cancel Sandbox Purchase"].forceTapElement()
        
        self.waitForElementToAppear(app.buttons["Billing Agreement with PayPal"])
        
        XCTAssertTrue(app.buttons["Cancelled"].exists);
    }
}
