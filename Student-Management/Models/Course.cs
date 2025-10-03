namespace StudentManagement.Models;

public class Course
{
    public int Id { get; set; }
    public string Title { get; set; }
    public decimal Credits { get; set; }
    public int InstructorId { get; set; }
}
