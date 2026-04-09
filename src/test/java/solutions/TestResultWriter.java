package solutions;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TestResultWriter {
    private final Path logFile;

    public TestResultWriter(String testName) throws IOException {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        Path logDir = Paths.get("logs");
        if (!Files.exists(logDir)) Files.createDirectories(logDir);

        // Создаем файл .md для красивого рендеринга таблиц
        this.logFile = logDir.resolve(testName + "_" + timestamp + ".md");
    }

    public void write(String message) {
        try {
            Files.writeString(logFile, message + System.lineSeparator(),
                    StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        } catch (IOException e) {
            throw new RuntimeException("Failed to write log", e);
        }
    }
}