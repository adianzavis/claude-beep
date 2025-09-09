#!/usr/bin/env swift

import AppKit

// Trigger haptic feedback using NSHapticFeedbackManager
if #available(macOS 10.11, *) {
    NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
}