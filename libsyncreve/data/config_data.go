package data

type ServiceConfData struct {
	Port       int    `json:"port" yaml:"port"`
	WorkingDir string `json:"working_dir" yaml:"working_dir"`
	TempDir    string `json:"temp_dir" yaml:"temp_dir"`
}
