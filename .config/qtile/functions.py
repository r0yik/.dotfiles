from libqtile.command import lazy

class Function(object):

##### KILL ALL WINDOWS #####

	@staticmethod
	def kill_all_windows():
		@lazy.function
		def __inner(qtile):
			for window in qtile.current_group.windows:
				window.kill()
		return __inner

	@staticmethod
	def kill_all_windows_minus_current():
		@lazy.function
		def __inner(qtile):
			for window in qtile.current_group.windows:
				if window != qtile.current_window:
					window.kill()
		return __inner
