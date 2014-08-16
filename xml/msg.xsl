<stylesheet version="1.0" 
xmlns="http://www.w3.org/1999/XSL/Transform">
<output method="text"/>
<template match="broadcast">
{starttime: <value-of select="start"/>, duration: <value-of select="duration"/>, title: <value-of select="programme/display_titles/title" />, episode: <value-of select="programme/display_titles/subtitle" />, episodeno: <value-of select="programme/position" />
}
</template>
</stylesheet>
