# elm-drag-and-drop-events

Lets you setup events through the HTML 5 drag and drop API.

## How to use

```elm
module App exposing (..)

import DragAndDropEvents exposing (..)

type alias Events = List String

type Msg
    = DragStart String
    | DragEnd String


update : Msg -> Events -> ( Events, Cmd Msg )
update msg events =
    case msg of
        DragStart box ->
            let
                events' =
                    ("Started dragging") :: events

            in
                ( events', Cmd.none )

        DragEnd box ->
            let
                events' =
                    ("Stopped dragging") :: events

            in
                ( events', Cmd.none )

view : Events -> Html Msg
view events =
    div
        [ draggable "true"
        , onDragStart DragStart
        , onDragEnd DragEnd
        ]
        [ text "This is your draggable" ]

```

You can find a more complete example [here](examples/src/Boxes.elm).

## Further reading

- [Native HTML5 Drag and Drop](http://www.html5rocks.com/en/tutorials/dnd/basics/)
