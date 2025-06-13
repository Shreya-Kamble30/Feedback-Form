import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String message = request.getParameter("message");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/college"; // Update with your database URL
        String dbUser  = "root"; // Update with your database username
        String dbPassword = "root"; // Update with your database password

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser , dbPassword);

            // Prepare the SQL statement
            String query = "INSERT INTO feedback (name, message) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, name);
            statement.setString(2, message);

            statement.executeUpdate();// redirect to your form page JSP or URL
            
            response.sendRedirect("index.html");
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
