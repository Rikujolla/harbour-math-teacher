# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-math-teacher

CONFIG += sailfishapp_qml

DISTFILES += qml/harbour-math-teacher.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-math-teacher.spec \
    rpm/harbour-math-teacher.yaml \
    translations/*.ts \
    harbour-math-teacher.desktop \
    qml/pages/QuizPage.qml \
    qml/pages/functions.js \
    qml/pages/About.qml \
    qml/pages/FunPage.qml \
    qml/pages/FlowersPage.qml \
    qml/pages/LevelChange.qml \
    rpm/harbour-math-teacher.changes \
    rpm/harbour-math-teacher.changes.run \
    qml/pages/LearningPage.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-math-teacher-de.ts
