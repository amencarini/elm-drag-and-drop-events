module DragAndDropEvents
    exposing
        ( onDragStart
        , onDrop
        , onDragOver
        , onDragEnter
        , onDragLeave
        , onDragEnd
        )

{-| This module provides with simple handlers for drag and drop HTML 5 events.

This is a crude initial implementation of these events. Right now all events
simply make use of Json.Decode.succeed. This can be reworked when Html.Events
supports the dataTransfer object.

# The events
@docs onDragStart, onDrop, onDragOver, onDragEnter, onDragLeave, onDragEnd
-}

import Html exposing (Attribute)
import Html.Events exposing (on, onWithOptions, Options)
import Json.Decode as Json

{-| Sends a message when the drag starts.
You can define this on the draggable.

    div 
        [ draggable "true", onDragStart (DragStart "1") ]
        [ text "box 1" ]
-}
onDragStart : msg -> Attribute msg
onDragStart message =
    on "dragstart" (Json.succeed message)

{-| Sends a message when the draggable gets dropped. 
You can define this on the droppable.
There is no information available about the draggable. Make sure to store that
somewhere if you need to know what's been dragged.

    div 
        [ onDrop (Drop "2") ]
        [ text "box 2" ]
-}
onDrop : msg -> Attribute msg
onDrop message =
    onWithOptions
        "drop"
        preventDefaultAndStopPropagation
        (Json.succeed message)


onDragOver : msg -> Attribute msg
onDragOver message =
    onWithOptions
        "dragover"
        preventDefault
        (Json.succeed message)

{-| Sends a message when a drag enters the element.
You can define this on the element that need to register that a drag entered 
it.

    div 
        [ onDragEnter (DragEnter "2") ]
        [ text "box 2" ]
-}
onDragEnter : msg -> Attribute msg
onDragEnter message =
    on "dragenter" (Json.succeed message)


{-| Sends a message when a drag leaves the element.
You can define this on the element that need to register that a drag left it.

    div 
        [ onDragLeave (DragLeave "2") ]
        [ text "box 2" ]
-}
onDragLeave : msg -> Attribute msg
onDragLeave message =
    on "dragleave" (Json.succeed message)


{-| Sends a message when a drag ends.
You can define this on the draggable.
Very useful to restore the draggable to its original state if the drag ends in
an unexpected place.

    div 
        [ onDragLeave (DragLeave "2") ]
        [ text "box 2" ]
-}
onDragEnd : msg -> Attribute msg
onDragEnd message =
    on "dragend" (Json.succeed message)


{-| Just a shorthand to clarify the options needed to have preventDefault on 
and stopPropagation off.
-}
preventDefault : Options
preventDefault =
    Options False True


{-| Just a shorthand to clarify the options needed to have both preventDefault
and stopPropagation on.
-}
preventDefaultAndStopPropagation : Options
preventDefaultAndStopPropagation =
    Options True True
