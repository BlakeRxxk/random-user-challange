.PHONY : kill_xcode

swiftlint=tools/swiftlint/bin/swiftlint
swiftformat=tools/swiftformat/bin/swiftformat

lint:
	${swiftlint} lint --config .swiftlint.yml

fix:
	${swiftlint} --fix

format:
	${swiftformat} --config "ruc.swiftformat" .

kill_xcode:
	killall Xcode || true
	killall Simulator || true