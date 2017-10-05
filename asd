List<string> original_file = new List<string>(File.ReadAllLines("Location of .osu"));
List<string> rated_file = original_file;
double DT = 1.5;
bool timingpoint_end = false;
bool hitobject_end = false;
for (int i = 0; i < original_file.Count - 1; i++)
{
  if ((original_file[i] == "[TimingPoints]" || timingpoint_end) && original[i + 1] != "")
  {
      timingpoint_end = true;
      string[] temp = original[i + 1].Split(',');
      temp[0] = (Convert.ToDouble(temp[0]) / DT).ToString();
      if (Convert.ToDouble(temp[1]) > 0)
      {
          temp[1] = Convert.ToDouble(Convert.ToDouble(temp[1]) / DT).ToString();
      }
      string rated_line = string.Join(",", temp);
      rated_line = rated_line.Remove(rated_line.Length - 1);
      rated[i + 1] = rated_line;
  }
  else
  {
      timingpoint_end = false;
  }

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
