package helpers

func StringsReverse(s string) string {
	output := []rune(s)
	for first, second := 0, len(output) - 1; first < len(output) / 2; first, second = first + 1, second - 1 {
		output[first], output[second] = output[second], output[first]
	}
	return string(output)
}
