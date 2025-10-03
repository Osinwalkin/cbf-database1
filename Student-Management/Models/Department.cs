namespace StudentManagement.Models;

public class Department
{
    public int Id { get; set; }
    public string Name { get; set; }
    public decimal Budget { get; set; }
    public DateTime StartDate { get; set; }
    //Foreign key
    public int? InstructorId { get; set; }
}   