package solutions;

import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

@Testcontainers
class SqlLiveCodingTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

    private TestResultWriter writer;

    @BeforeEach
    void setUp(TestInfo testInfo) throws Exception {
        writer = new TestResultWriter(testInfo.getDisplayName());
        // Инициализируем базу схемой и данными (без лога результата)
        executeSqlFile("src/main/resources/sql/init.sql", false);
    }

    @ParameterizedTest
    @ValueSource(ints = {7})
    void task(int taskNumber) throws Exception {
        writer.write("# Результат выполнения задачи №" + taskNumber);
        executeSqlFile(String.format("src/main/resources/sql/task%d.sql", taskNumber), true);
    }

    private void executeSqlFile(String path, boolean isTask) throws Exception {
        String sql = Files.readString(Path.of(path));
        try (Connection conn = DriverManager.getConnection(postgres.getJdbcUrl(),
                postgres.getUsername(), postgres.getPassword())) {

            Statement stmt = conn.createStatement();
            boolean hasResultSet = stmt.execute(sql);

            if (isTask && hasResultSet) {
                writer.write("```text\n" + formatResultSet(stmt.getResultSet()) + "\n```");
            }
        }
    }

    private String formatResultSet(ResultSet rs) throws Exception {
        ResultSetMetaData meta = rs.getMetaData();
        int cols = meta.getColumnCount();
        List<String> headers = new ArrayList<>();
        for (int i = 1; i <= cols; i++) headers.add(meta.getColumnName(i));

        List<List<String>> data = new ArrayList<>();
        while (rs.next()) {
            List<String> row = new ArrayList<>();
            for (int i = 1; i <= cols; i++) row.add(String.valueOf(rs.getObject(i)));
            data.add(row);
        }

        int[] widths = new int[cols];
        for (int i = 0; i < cols; i++) {
            widths[i] = headers.get(i).length();
            for (List<String> row : data) widths[i] = Math.max(widths[i], row.get(i).length());
        }

        String line = "+" + Arrays.stream(widths).mapToObj(w -> "-".repeat(w + 2)).collect(Collectors.joining("+")) + "+\n";
        StringBuilder sb = new StringBuilder(line);

        // Header
        sb.append("|");
        for (int i = 0; i < cols; i++) sb.append(String.format(" %-" + widths[i] + "s |", headers.get(i)));
        sb.append("\n").append(line.replace("-", "="));

        // Rows
        for (List<String> row : data) {
            sb.append("|");
            for (int i = 0; i < cols; i++) sb.append(String.format(" %-" + widths[i] + "s |", row.get(i)));
            sb.append("\n");
        }
        return sb.append(line).toString();
    }
}