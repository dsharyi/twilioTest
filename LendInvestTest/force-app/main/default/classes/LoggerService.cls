public with sharing class LoggerService {
    public static List <Custom_Logger__c> customLoggers = new List <Custom_Logger__c> ();

    public static final String TWILIO_TYPE_SERVICE = 'Twilio';

    public static void createLoggerFromFailedSMSToGoldAccount (List <String> listOfResponseBodiesWithError, List <String> listOfBodiesContentSMSWithError) {
        for (String repsoneBodyWithError : listOfResponseBodiesWithError) {
            for (String bodyContentSMSWithError : listOfBodiesContentSMSWithError) {
                Custom_Logger__c customLogger = new Custom_Logger__c (
                    Type_of_Service__c = TWILIO_TYPE_SERVICE,
                    Reason_of_failed_SMS_Twilio__c = repsoneBodyWithError.substringBetween('message": "', '"'),
                    To_Mobile_Number__c = bodyContentSMSWithError.substringBetween('To=', '&'),
                    From_Mobile_Number__c = bodyContentSMSWithError.substringBetween('From=', '&'),
                    Content_SMS__c = bodyContentSMSWithError.substringAfter('Body='));
                    customLoggers.add(customLogger);
            }
        }
        insert customLoggers;
    }
}