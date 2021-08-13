global with sharing class TwilioHttpCalloutMock implements HttpCalloutMock {
    private static final String responseBody = '{' +
        '"sid":"' + UtilConstantsForTest.MOCK_SID + '",' +
        '"date_created":' + UtilConstantsForTest.MOCK_SMS_DATE_CREATED + '",' +
        '"date_updated":"' + UtilConstantsForTest.MOCK_SMS_DATE_UPDATED + '",' +
        '"date_sent": null,' +
        '"account_sid":"' + UtilConstantsForTest.TWILIO_ACCOUNT_SID + '",' +
        '"to":"' + UtilConstantsForTest.MOBILE_PHONE_ACCOUNT + '",' +
        '"from":"' + UtilConstantsForTest.TWILIO_MOBILE_NUMBER_FROM + '",' +
        '"messaging_service_sid": null,' +
        '"body":"' + UtilConstantsForTest.TWILIO_SMS_BODY + '",' +
        '"status":"' + UtilConstantsForTest.MOCK_SMS_STATUS + '",' +
        '"num_segments": "1",' +
        '"num_media": "0",' +
        '"direction":"' + UtilConstantsForTest.MOCK_DIRECTION + '",' +
        '"api_version":"' + UtilConstantsForTest.MOCK_API_VERSION + '",' +
        '"price": null,' +
        '"price_unit":"' + UtilConstantsForTest.MOCK_PRICE_UNIT + '",' +
        '"error_code": null,' +
        '"error_message": null' +
    '}';
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(201);
        response.setBody(responseBody);
        return response;
    }
}