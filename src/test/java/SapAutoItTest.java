import org.junit.Test;

import java.io.IOException;

public class SapAutoItTest {
    private static final String AUTO_IT_SCRIPT_PATH = System.getProperty("auto.it.script.path");
    private static final String TEXT_FILE_PATH = System.getProperty("text.file.path");

    @Test
    public void testInputKeyInSapLogonFromFile() throws IOException {
        String AutoItScript = AUTO_IT_SCRIPT_PATH + "SAPLogon.exe";
        String InputTextFile = TEXT_FILE_PATH + "SAPLogonKey.txt";
        Runtime.getRuntime().exec(AutoItScript + " " + InputTextFile);
    }
}