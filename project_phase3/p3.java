import java.sql.*;
import java.util.Scanner;

public class p3_scanner {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        Connection connection = null;

        try {
            // user input
            System.out.println("Enter UserID: ");
            String USERID = scanner.nextLine();
            System.out.println("Enter Password: ");
            String PASSWORD = scanner.nextLine();
            System.out.println("Enter Connection String (jdbc:oracle:thin:@csorcl.cs.wpi.edu:1521:orcl): ");
            String CONNECTIONSTRING = scanner.nextLine();

            // attempt to establish connection to database
            connection = DriverManager.getConnection(CONNECTIONSTRING, USERID, PASSWORD);
            System.out.println("Connected Successfully!");

            System.out.println("\nMenu Items: \n1 - Report Location Information\n2 - Report Edge Information\n3 - Report CS Staff Information\n4 - Insert New Phone Extension\n0 - Exit Program\n\nEnter Menu Item: ");
            String MENUITEM = scanner.nextLine();

            switch (MENUITEM) {
                case "1":
                    locations(connection);
                    break;
                case "2":
                    edges(connection);
                    break;
                case "3":
                    csstaff(connection);
                    break;
                case "4":
                    insertPhone(connection);
                    break;
                case "0":
                    System.out.println("Exiting Program");
                    break;
                default:
                    System.out.println("Invalid menu item selection. Please try again");
                    break;
            }
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }

    public static void locations (Connection connection) throws SQLException {
        // user input
        Scanner locationScanner = new Scanner(System.in);
        System.out.println("Enter Location ID: ");
        String locationID = locationScanner.nextLine();

        // create query
        String sql = "select * from Locations where locationID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, locationID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // print location information
                    System.out.println("Location Information");
                    System.out.println("Location ID: " + rs.getString("LocationID"));
                    System.out.println("Location Name: " + rs.getString("LocationName"));
                    System.out.println("Location Type: " + rs.getString("LocationType"));
                    System.out.println("X-Coordinate: " + rs.getDouble("XCoord"));
                    System.out.println("Y-Coordinate: " + rs.getDouble("YCoord"));
                    System.out.println("Floor: " + rs.getInt("MapFloor"));
                } else {
                    System.out.println("Location could not be found");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            locationScanner.close();
        }
    }

    public static void edges (Connection connection) throws SQLException {
        // user input
        Scanner edgeScanner = new Scanner(System.in);
        System.out.println("Enter Edge ID: ");
        String edgeID = edgeScanner.nextLine();

        // create query
        String sql = "select e.edgeID, s.locationName as startingLocationName, s.mapFloor as startingLocationFloor, " +
                "en.locationName as endingLocationName, en.mapFloor as endingLocationFloor from Edges e " +
                "join Locations s on e.startingLocationID = s.locationID " +
                "join Locations en on e.endingLocationID = en.locationID " +
                "where e.edgeID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, edgeID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // print edge information
                    System.out.println("Edge Information");
                    System.out.println("Edge ID: " + rs.getString("edgeID"));
                    System.out.println("Starting Location Name: " + rs.getString("startingLocationName"));
                    System.out.println("Starting Location Floor: " + rs.getString("startingLocationFloor"));
                    System.out.println("Ending Location Name " + rs.getString("endingLocationName"));
                    System.out.println("Ending Location Floor: " + rs.getString("endingLocationFloor"));
                } else {
                    System.out.println("Edge could not be found");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            edgeScanner.close();
        }
    }

    public static void csstaff(Connection connection) throws SQLException {
        // user input
        Scanner staffScanner = new Scanner(System.in);
        System.out.println("Enter CS Staff Account Name: ");
        String staffName = staffScanner.nextLine();

        // create query
        String sql = "select c.accountName, c.firstName, c.lastName, c.officeID, t.titleName " +
                "from CSStaff c " +
                "left join CSStaffTitles cst on c.accountName = cst.accountName " +
                "left join Titles t on cst.acronym = t.acronym " +
                "where c.accountName = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staffName);

            try (ResultSet rs = stmt.executeQuery()) {
                boolean found = false;
                StringBuilder titles = new StringBuilder();

                while (rs.next()) {
                    if (!found) {
                        // print staff information
                        System.out.println("CS Staff Information");
                        System.out.println("Account Name: " + rs.getString("accountName"));
                        System.out.println("First Name: " + rs.getString("firstName"));
                        System.out.println("Last Name: " + rs.getString("lastName"));
                        System.out.println("Office ID: " + rs.getString("officeID"));
                        found = true;
                    }

                    // print title information
                    if (titles.length() > 0) {
                        titles.append(", ");
                    }
                    titles.append(rs.getString("titleName"));
                }

                if (!found) {
                    System.out.println("CS Staff with account name '" + staffName + "' could not be found.");
                }

                System.out.println("Title(s): " + titles.toString());

                // create query & print phone extensions
                StringBuilder phoneExts = new StringBuilder();
                String phoneSql = "select phoneExt from PhoneExtensions where accountName = ?";
                try (PreparedStatement phoneStmt = connection.prepareStatement(phoneSql)) {
                    phoneStmt.setString(1, staffName);

                    try (ResultSet phoneRS = phoneStmt.executeQuery()) {
                        while (phoneRS.next()) {
                            if (phoneExts.length() > 0) {
                                phoneExts.append(", ");
                            }
                            phoneExts.append(phoneRS.getString("phoneExt"));
                        }
                    }
                }

                // print phone extensions
                if (phoneExts.length() > 0) {
                    System.out.println("Phone Extension(s): " + phoneExts.toString());
                } else {
                    System.out.println("Phone Extension(s): None");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            staffScanner.close();
        }
    }

    public static void insertPhone (Connection connection) throws SQLException {
        //user input
        Scanner phoneScanner = new Scanner(System.in);

        try {
            System.out.println("Enter CS Staff Account Name: ");
            String staffName = phoneScanner.nextLine();
            System.out.println("Enter the new Phone Extension: ");
            String newPhone = phoneScanner.nextLine();

            // create query
            String sql = "insert into PhoneExtensions (accountName, phoneExt) values (?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, staffName);
                stmt.setString(2, newPhone);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("New phone extension " + newPhone + " inserted successfully for " + staffName);
                } else {
                    System.out.println("New phone extension insertion unsuccessful");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            phoneScanner.close();
        }
    }
}
