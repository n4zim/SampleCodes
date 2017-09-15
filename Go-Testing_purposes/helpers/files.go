package helpers

import (
	"io/ioutil"
	"../types"
)

func FilesLoad(name string) (*types.File, error) {
	filename := "data/" + name + ".txt"
	body, err := ioutil.ReadFile(filename)
	if err != nil { return nil, err }
	return &types.File { Name: name, Content: body }, nil
}
