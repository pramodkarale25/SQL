using System;
using System.Data;
using System.Data.SqlClient;

namespace SQL
{
    public class SQLQuery
    {
        public void ConnectedArchitecture()
        {

            try
            {
                string ConString = @"data source=LAPTOP-ICA2LCQL\SQLEXPRESS; database=EmployeeDB; integrated security=SSPI";
                using (SqlConnection connection = new SqlConnection(ConString))
                {
                    // Creating the command object
                    SqlCommand cmd = new SqlCommand("select Name, Email, Mobile from Employee", connection);

                    // Opening Connection  
                    connection.Open();

                    // Executing the SQL query  
                    SqlDataReader sdr = cmd.ExecuteReader();

                    //Looping through each record
                    //SqlDataReader works in Connection Oriented Architecture
                    //So, it requires an active and open connection while reading the data
                    //from the database
                    if (sdr != null && sdr.HasRows)
                    {
                        while (sdr.Read())
                        {
                            //Read-only, you cannot modify the data
                            //sdr["Name"] = "PKR";
                            Console.WriteLine(sdr["Name"] + ",  " + sdr["Email"] + ",  " + sdr["Mobile"]);
                            //connection.Close();//Here, the connection is closed manually. throw exception
                        }
                    }
                }//Here, the connection is going to be closed automatically
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception Occurred: {ex.Message}");
            }

        }

        public void DisConnectedArchitecture()
        {
            try
            {
                // Connection string.  
                string connectionString = @"data source=LAPTOP-ICA2LCQL\SQLEXPRESS; database=EmployeeDB; integrated security=SSPI";

                // Connect to the EmployeeDB database.  
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Create a SqlDataAdapter  
                    SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM EMPLOYEE", connection);
                    //Fetch the Employee Data and Store it in the DataTable
                    DataTable dataTable = new DataTable();// wecan put this at the top

                    //The Fill method will open the connection, fetch the data, fill the data in
                    //the data table and close the connection automatically
                    adapter.Fill(dataTable);

                    // Set the UPDATE command and parameters.
                    string UpdateQuery = "UPDATE Employee SET Name=@Name, Email=@Email, Mobile=@Mobile WHERE ID=@EmployeeID;";
                    adapter.UpdateCommand = new SqlCommand(UpdateQuery, connection);
                    adapter.UpdateCommand.Parameters.Add("@Name", SqlDbType.NVarChar, 50, "Name");
                    adapter.UpdateCommand.Parameters.Add("@Email", SqlDbType.NVarChar, 50, "Email");
                    adapter.UpdateCommand.Parameters.Add("@Mobile", SqlDbType.NVarChar, 50, "Mobile");
                    adapter.UpdateCommand.Parameters.Add("@EmployeeID", SqlDbType.Int, 4, "ID");
                    //Set UpdatedRowSource value as None
                    //Any Returned parameters or rows are Ignored.
                    adapter.UpdateCommand.UpdatedRowSource = UpdateRowSource.None;

                    //Change the Column Values of Few Rows
                    DataRow Row1 = dataTable.Rows[0];
                    Row1["Name"] = "Name Changed";
                    DataRow Row2 = dataTable.Rows[1];
                    Row2["Email"] = "Email Changed";
                    DataRow Row3 = dataTable.Rows[2];
                    Row2["Mobile"] = "Mobile Changed";

                    // Execute the update.  
                    //The Update method will open the connection, execute the Update command by takking
                    //the data table data and then close the connection automatically
                    adapter.Update(dataTable);

                    Console.WriteLine($"Updated Data Saved into the DataBase");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception Occurred: {ex.Message}");
            }


        }

        public void BulkInsert()
        {
            string sqlQuery = "select * from Customers where 0 = 1";
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "Data Source=PRAMOD;Initial Catalog=Test;Integrated Security=True";
            
            SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlQuery, conn);
            DataSet dataSet = new DataSet();
            dataAdapter.TableMappings.Add("Table", "Customers");
            dataAdapter.Fill(dataSet);
            //dataSet.Tables[0].TableName = "Customers";
            DataRow newRow;

            for (int i = 1; i < 10; i++)
            {
                newRow = dataSet.Tables["Customers"].NewRow();
                newRow["CustomerID"] = i;
                dataSet.Tables["Customers"].Rows.Add(newRow);
            }

            new SqlCommandBuilder(dataAdapter);//insert command is automatically generated for you.
            dataAdapter.Update(dataSet);
        }

        public void SqlCommandMethods()
        {
            SqlCommand cmd = new SqlCommand();
            cmd.ExecuteNonQuery();// for INSERT/UPDATE/DELETE
            cmd.ExecuteReader();// for reading multiple records
            cmd.ExecuteScalar();// for reading single value
        }
    }
}
