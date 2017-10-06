List<string> original_file = new List<string>(File.ReadAllLines("Location of .osu"));
List<string> rated_file = original_file;
double DT = 1.5;
bool hitobject_end = false;
for (int i = 0; i < original_file.Count - 1; i++)
{
  if ((original[i] == "[HitObjects]" || hitobject_end) && original[i + 1] != "")
  {
      hitobject_end = true;
      string original_sor = original[i + 1];
      string[] temp = original_sor.Split(',');
      temp[2] = Convert.ToInt32((Convert.ToInt32(temp[2]) / DT)).ToString();
      //ln
      string[] timing = temp[5].Split(':');
      timing[0] = Convert.ToInt32((Convert.ToInt32(timing[0]) / DT)).ToString();
      string ln = string.Join(":", timing);
      ln = ln.Remove(ln.Length - 1);
      //
      temp[5] = ln;
      string note = string.Join(",", temp);
      rated[i + 1] = note + ln;
      }
}
File.WriteAllLines("Location of new .osu", rated);
