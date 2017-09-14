package types

import "io/ioutil"

type File struct {
	Name string
	Content []byte
}

func (p *File) Save() error {
	filename := "data/" + p.Name + ".txt"
	return ioutil.WriteFile(filename, p.Content, 0600)
}
