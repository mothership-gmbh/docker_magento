<?php
/**
 * This file is part of the Mothership GmbH code.
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
class Local extends Mothership\StateMachine\StateMachine
{
    /**
     * Create the workflow.
     *
     * @throws \Mothership\StateMachine\Exception\StateMachineException
     */
    protected function initWorkflow()
    {
    }

    /**
     * create a graph for the state machine.
     *
     * @param string     $outputPath         relative path of the generated image
     * @param bool|false $stopAfterExecution if we want to exit after graphic generation
     *
     * @return void
     */
    public function renderGraph($path)
    {
        /*
         * This example is based on http://martin-thoma.com/how-to-draw-a-finite-state-machine/
         * Feel free to tweak the rendering output. I have decided do use the most simple
         * implementation over the fancy stuff to avoid additional complexity.
         */
        $template
            = '
@startuml
digraph finite_state_machine {
                rankdir=LR;
                size="%d"

                node [shape = doublecircle]; start;
                node [shape = circle]; finish;
                node [shape = box];

                %s
            }
            @enduml
        ';

        $pattern = ' %s  -> %s [ label = "%s" ];';

        $_transitions = [];
        foreach ($this->workflowConfiguration['states'] as $state) {
            if (array_key_exists('transitions_from', $state)) {
                $transitions_from = $state['transitions_from'];
                foreach ($transitions_from as $from) {
                    if (is_array($from)) {
                        $_transitions[] = sprintf(
                            $pattern,
                            $from['status'],
                            $state['name'],
                            '<< IF '
                            . $this->convertToStringCondition($from['result']) . ' >>' . $state['name']
                        );
                    } else {
                        $_transitions[] = sprintf($pattern, $from, $state['name'], $state['name']);
                    }
                }
            } else {
                if ('type' == 'exception') {
                    $_transitions[] = 'node [shape = doublecircle]; exception;';
                }
            }
        }
        file_put_contents($path , sprintf($template, count($_transitions) * 2, implode("\n", $_transitions)));
        exit;
    }

    /**
     * Internal method required for the rendering.
     *
     * @param $condition
     *
     * @return string
     */
    private function convertToStringCondition($condition)
    {
        if (is_bool($condition)) {
            if ($condition) {
                return 'TRUE';
            } else {
                return 'FALSE';
            }
        }

        return (string) $condition;
    }
}