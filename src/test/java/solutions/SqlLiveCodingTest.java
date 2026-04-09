package solutions;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.testcontainers.containers.PostgreSQLContainer;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class SqlLiveCodingTest {
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");
    private TestResultWriter writer;

    @BeforeAll
    static void startContainer() {
        postgres.start();
    }

    @BeforeEach
    void setup(TestInfo testInfo) throws Exception {
        // Создаем новый лог-файл для каждого теста (или метода)
        writer = new TestResultWriter(testInfo.getDisplayName().replace("()", ""));
        executeSqlFile("src/main/resources/sql/init.sql", false);
    }

    @ParameterizedTest
    @ValueSource(ints = {6})
    void runTask(int taskNumber) throws Exception {
        writer.write("--- Запуск задачи №" + taskNumber + " ---");
        executeSqlFile(String.format("src/main/resources/sql/task%d.sql", taskNumber), true);
    }

    private void executeSqlFile(String path, boolean logResult) throws Exception {
        String sql = Files.readString(Path.of(path));
        try (var conn = DriverManager.getConnection(
                postgres.getJdbcUrl(), postgres.getUsername(), postgres.getPassword())) {
            var stmt = conn.createStatement();
            stmt.execute(sql);

            if (logResult) {
                var rs = stmt.getResultSet();
                if (rs != null) {
                    writeResultSetToFile(rs);
                }
            }
        }
    }

    private void writeResultSetToFile(ResultSet rs) throws Exception {
        var metaData = rs.getMetaData();
        int columns = metaData.getColumnCount();

        while (rs.next()) {
            StringBuilder row = new StringBuilder();
            for (int i = 1; i <= columns; i++) {
                row.append(metaData.getColumnName(i))
                        .append(": ")
                        .append(rs.getObject(i))
                        .append(" | ");
            }
            writer.write(row.toString());
        }
    }
}
