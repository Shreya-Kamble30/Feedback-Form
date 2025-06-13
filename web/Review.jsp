<%@page import="org.apache.tomcat.jakartaee.commons.lang3.StringEscapeUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reviews and Feedback</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="review.css">
</head>
<body>
    <main>
        <h1>Reviews and Feedback</h1>
        <section class="cards-container" aria-label="User  reviews and feedback">
            <%
                // Database connection setup
                String dbURL = "jdbc:mysql://localhost:3306/college";
                String dbUser   = "root";
                String dbPass = "root";

                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser  , dbPass);
                    String sql = "SELECT name, message FROM feedback ORDER BY id DESC";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    int count = 0;
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String message = rs.getString("message");
                        count++;
            %>
            <article class="card" role="article" aria-labelledby="name<%=count%>" tabindex="0">
                <div class="card-name">
                    <span class="material-icons" aria-hidden="true">account_circle</span>
                    <span id="name<%=count%>"><%= StringEscapeUtils.escapeHtml4(name) %></span>
                </div>
                <p class="card-message"><%= StringEscapeUtils.escapeHtml4(message) %></p>
            </article>
            <%
                    }
                    if(count == 0) {
            %>
            <p>No feedback yet. Be the first to leave a comment!</p>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error loading feedback: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch(Exception ignore) {}
                    if (ps != null) try { ps.close(); } catch(Exception ignore) {}
                    if (conn != null) try { conn.close(); } catch(Exception ignore) {}
                }
            %>
        </section>
        <button class="add-feedback" onclick="window.location.href='index.html'">Add Feedback</button>
    </main>
</body>
</html>