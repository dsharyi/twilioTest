@isTest
public with sharing class TestLoggerService {
    @testSetup 
    static void setup() {
        TwilioConfiguration__c twilioConfig = new TwilioConfiguration__c();
        twilioConfig.Name = UtilConstantsForTest.TWILIO_CS_NAME;
        twilioConfig.Account_sId__c = UtilConstantsForTest.TWILIO_ACCOUNT_SID;
        twilioConfig.Auth_Token__c = UtilConstantsForTest.TWILIO_AUTH_TOKEN;
        twilioConfig.MobileNumberFrom__c = UtilConstantsForTest.TWILIO_MOBILE_NUMBER_FROM;
        twilioConfig.SMS_Body__c = UtilConstantsForTest.TWILIO_SMS_BODY;
        twilioConfig.TwilioEndpoint__c = UtilConstantsForTest.TWILIO_ENDPOINT;
        twilioConfig.TwilioTypeOfOperation__c = UtilConstantsForTest.TWILIO_TYPE_OF_OPERATION;
        insert twilioConfig;
        
    }

    @isTest 
	static void testCreateLoggerFromFailedSMSToGoldAccountNegativeCase() {

        List<String> listOfResponseBodiesWithError = new List<String>();
        List<String> listOfBodiesContentSMSWithError = new List<String>();

        LoggerService.createLoggerFromFailedSMSToGoldAccount(listOfResponseBodiesWithError, listOfBodiesContentSMSWithError);

        System.assertEquals(true, LoggerService.customLoggers.isEmpty());
        
    }

    @isTest 
	static void testCreateLoggerFromFailedSMSToGoldAccountPositiveCase() {

        List<String> listOfResponseBodiesWithError = new List<String>{UtilConstantsForTest.MOCK_RESPONSE_BODY_ERROR};
        List<String> listOfBodiesContentSMSWithError = new List<String>{UtilConstantsForTest.MOCK_SMS_BODY_ERROR}; 

        LoggerService.createLoggerFromFailedSMSToGoldAccount(listOfResponseBodiesWithError, listOfBodiesContentSMSWithError);

        System.assertEquals(false, LoggerService.customLoggers.isEmpty());
        
    }
}