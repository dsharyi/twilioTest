public with sharing class UtilConstantsForTest {
    public static final String GOLD_ACCOUNT_NAME = 'TestGoldAccount';
    public static final String SILVER_ACCOUNT_NAME = 'TestSilverAccount';
    public static final String MOBILE_PHONE_ACCOUNT = '+380507455060';

    public static final String GOLD_OPPORTUNITY_NAME = 'TestOpportunityWithGoldAcc';
    public static final String STAGE_CLOSED_WON = 'Closed Won';
    public static final Integer AMOUNT_GOLD_OPPORTUNITY = 50000;

    public static final String SILVER_OPPORTUNITY_NAME = 'TestOpportunityWithSilverAcc';
    public static final Integer AMOUNT_SILVER_OPPORTUNITY = 10000;

    public static final String TWILIO_CS_NAME = 'TwilioCS';
    public static final String TWILIO_ACCOUNT_SID = 'ACcce20c97f6e7fb9434977527661ee186';
    public static final String TWILIO_AUTH_TOKEN = '3bc4e36de12c183360ff127aa9a307c3';
    public static final String TWILIO_MOBILE_NUMBER_FROM = '+15053093234';
    public static final String TWILIO_SMS_BODY = 'Test text';
    public static final String TWILIO_ENDPOINT = 'https://api.twilio.com/2010-04-01/Accounts/';
    public static final String TWILIO_TYPE_OF_OPERATION = '/Messages.json';

    public static final String MOCK_SMS_DATE_CREATED = 'Thu, 12 Aug 2021 07:58:12 +0000';
    public static final String MOCK_SMS_DATE_UPDATED = 'Thu, 12 Aug 2021 07:58:12 +0000';
    public static final String MOCK_SMS_STATUS = 'queued';
    public static final String MOCK_SID = 'SMa245627553d4455fa9153c61d0966298';
    public static final String MOCK_DIRECTION = 'outbound-api';
    public static final String MOCK_API_VERSION = '2010-04-01';
    public static final String MOCK_PRICE_UNIT = 'USD';

    public static final Integer RESPONSE_ERROR_CODE = 21212;
    public static final String RESPONSE_ERROR_MESSAGE = 'The From number  15053093234///0000 is not a valid phone number, shortcode, or alphanumeric sender ID.';
    public static final String RESPONSE_ERROR_MORE_INFO = 'https://www.twilio.com/docs/errors/21212';
    public static final Integer RESPONSE_ERROR_STATUS = 400;

    public static final String SMS_ERROR_FROM_NUMBER = '+15053093234';

    public static final String MOCK_RESPONSE_BODY_ERROR = '{' +
        '"code":' + RESPONSE_ERROR_CODE + ',' +
        '"message":' + RESPONSE_ERROR_MESSAGE + '",' +
        '"more_info":"' + RESPONSE_ERROR_MORE_INFO + '",' +
        '"status":' + RESPONSE_ERROR_MORE_INFO + ',' +
    '}';

    public static final String MOCK_SMS_BODY_ERROR = 
                                                    'To=' + MOBILE_PHONE_ACCOUNT + '&&' +
                                                    'From=' + SMS_ERROR_FROM_NUMBER + '&&'+
                                                    'Body=' + TWILIO_SMS_BODY;

}
