//
//  main.swift
//  Finder2App
//
//  Created by Kael on 2020/12/9.
//

import Foundation

let scpt = """
on getFinderPath()
    tell application "Finder"
        return POSIX path of ((target of front Finder window) as text)
    end tell
end getFinderPath

# do shell script "/usr/bin/open -a iTerm " & getFinderPath() # we cannot do this in script. (no escape character handling)
return getFinderPath()
"""

let script = NSAppleScript(source: scpt)

guard let path = script?.executeAndReturnError(nil).stringValue else {
    exit(-1)
}

let process = Process()
process.launchPath = "/usr/bin/open"
process.arguments = ["-a", "iTerm", "\(path)"]

process.launch()
process.waitUntilExit()
